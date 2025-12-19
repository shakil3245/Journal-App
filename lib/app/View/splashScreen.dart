import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controller/authController.dart';

class SplashScreen extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      authController.checkLogin();
    });

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
         SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
        ],
      )),
    );
  }
}