import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_4_food_classification_app/app_route/app_routes.dart';
import 'package:task_4_food_classification_app/controller/detection_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // ensure controller is put before navigation
                if (!Get.isRegistered<DetectionController>()) {
                  Get.put(DetectionController());
                }
                Get.toNamed(
                  AppRoutes.streamDetectionScreen,
                  arguments: {"type": "streaming"},
                );
              },
              child: Text('Start Detection (Stream)'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (!Get.isRegistered<DetectionController>()) {
                  Get.put(DetectionController());
                }
                Get.toNamed(
                  AppRoutes.detectionScreen,
                  arguments: {"type": "picture"},
                );
              },
              child: Text('Take Picture'),
            ),
          ],
        ),
      ),
    );
  }
}
