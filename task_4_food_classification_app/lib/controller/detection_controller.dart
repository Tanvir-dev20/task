import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class DetectionController extends GetxController {
  late CameraController cameraController;
  RxBool isInitialized = false.obs;
  RxString result = ''.obs;
  bool isProcessing = false;
  bool _isStreaming = false;

  @override
  void onInit() async {
    super.onInit();
    await initializeCamera();
    await loadDataModel();
  }

  @override
  void onClose() {
    cameraController.dispose();
    Tflite.close();
  }

  Future<void> loadDataModel() async {
    await Tflite.close();
    final res = await Tflite.loadModel(
      model: "assets/models/food_101_model.tflite",
      labels: "assets/models/food_101_labels.txt",
    );
    print('Tflite loadModel result: $res');
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      result.value = 'No cameras found';
      return;
    }

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await cameraController.initialize();
    isInitialized.value = true;

    if (Get.arguments['type'] == 'streaming') {
      _isStreaming = true;
      cameraController.startImageStream(_processFrame);
    }
  }

  // classification on each frame
  void _processFrame(CameraImage img) async {
    if (isProcessing) return;
    isProcessing = true;
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      final predictions = await Tflite.runModelOnFrame(
        bytesList: img.planes.map((p) => p.bytes).toList(),
        imageHeight: img.height,
        imageWidth: img.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 3,
        threshold: 0.2,
        asynch: true,
      );

      if (predictions != null && predictions.isNotEmpty) {
        result.value = predictions
            .map(
              (p) =>
                  '${p['label']} - ${(p['confidence'] * 100).toStringAsFixed(1)}%',
            )
            .join('\n');
      } else {
        result.value = 'No recognitions';
      }
    } catch (e) {
      print('Frame error: $e');
    } finally {
      isProcessing = false;
    }
  }

  // classification on a still image
  Future<void> takePictures() async {
    if (!isInitialized.value) return;
    try {
      final XFile file = await cameraController.takePicture();
      final File image = File(file.path);
      if (isProcessing) return;
      isProcessing = true;
      result.value = '';

      final predictions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 3,
        threshold: 0.2,
      );

      if (predictions != null && predictions.isNotEmpty) {
        result.value = predictions
            .map(
              (p) =>
                  '${p['label']} - ${(p['confidence'] * 100).toStringAsFixed(1)}%',
            )
            .join('\n');
      } else {
        result.value = 'No recognitions';
      }
    } catch (e) {
      print('Picture detection error: $e');
      result.value = 'Error: $e';
    } finally {
      isProcessing = false;
    }
  }
}
