import 'package:get/get_navigation/get_navigation.dart';
import 'package:task_4_food_classification_app/app_route/app_routes.dart';
import 'package:task_4_food_classification_app/binding/detection_binding.dart';
import 'package:task_4_food_classification_app/pages/detection_screen.dart';
import 'package:task_4_food_classification_app/pages/home_page.dart';
import 'package:task_4_food_classification_app/pages/stream_detection_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.homePage, page: () => HomePage()),
    GetPage(
      binding: DetectionBinding(),
      name: AppRoutes.streamDetectionScreen,
      page: () => StreamDetectionScreen(),
    ),
    GetPage(
      binding: DetectionBinding(),
      name: AppRoutes.detectionScreen,
      page: () => DetectionScreen(),
    ),
  ];
}
