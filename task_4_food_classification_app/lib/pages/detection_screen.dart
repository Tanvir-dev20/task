import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_4_food_classification_app/controller/detection_controller.dart';

class DetectionScreen extends GetView<DetectionController> {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take Food Picture')),
      body: Obx(() {
        if (!controller.isInitialized.value) {
          if (controller.result.value.isNotEmpty) {
            return Center(child: Text(controller.result.value));
          }
          return const Center(child: CircularProgressIndicator());
        }

        if (!controller.cameraController.value.isInitialized) {
          return const Center(child: Text('Camera not initialized'));
        }

        return Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: controller.cameraController.value.aspectRatio,
                child: CameraPreview(controller.cameraController),
              ),
            ),
            Positioned(
              bottom: 120,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => Text(
                    controller.result.value.isEmpty
                        ? 'Press camera button to classify'
                        : controller.result.value,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.takePictures(),
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
