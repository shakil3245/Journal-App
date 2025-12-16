import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/authController.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter Name";
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter email";
                  if (!value.contains('@')) return "Enter valid email";
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter password";
                  if (value.length < 6) return "Password must be at least 6 chars";
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
                validator: (value) {
                  if (value != passwordController.text) return "Passwords do not match";
                  return null;
                },
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: roleController,
                decoration: InputDecoration(labelText: "User/Admin"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter who you are! ";

                  return null;
                },
              ),
              SizedBox(height: 16),
              Obx(() => authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  authController.registerUser(nameController.text, emailController.text, passwordController.text,roleController.text);

                } ,
                child: Text('Register'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}