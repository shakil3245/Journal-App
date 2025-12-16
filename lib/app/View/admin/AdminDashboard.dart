import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../controller/authController.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AuthController authcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal Admin",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
              print('Search tapped');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: "Logout",
                middleText: "Do you want to logout?",
                textConfirm: "Yes",
                textCancel: "No",
                onConfirm: () {
                  Get.back();
                  authcontroller.logout();
                },
              );
            },
          ),
        ],
      ),
      body: Column(children: [Center(child: Text("Welcome Admin",style: TextStyle(fontSize: 20),))]),
    );
  }
}
