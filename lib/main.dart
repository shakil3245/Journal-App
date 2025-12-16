import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/controller/authController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      authController.checkLogin();
    });

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
