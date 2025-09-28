import 'package:get/get.dart';
import 'package:task_4_food_classification_app/controller/detection_controller.dart';

class DetectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetectionController());
  }
}
