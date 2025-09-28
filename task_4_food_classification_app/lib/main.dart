import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_4_food_classification_app/app_route/app_pages.dart';
import 'package:task_4_food_classification_app/app_route/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.homePage,
    );
  }
}
