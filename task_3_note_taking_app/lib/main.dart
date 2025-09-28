import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/bindings/initial_bindings.dart';
import 'presentation/controllers/settings_controller.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitialBindings().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes App',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode:
              settingsController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: HomePage(),
        );
      },
    );
  }
}
