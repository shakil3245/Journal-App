import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:journal/app/View/Auth%20Screens/registrationUser.dart';


import '../../controller/authController.dart';

import '../widgets/cutomButton.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 100),
              Text("Welcome To Login",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),),
              SizedBox(height: 90),

              TextFormField(
                controller: emailController,

                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
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
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter password";
                  if (value.length < 6) {
                    return "Password must be at least 6 chars";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              Obx(
                () => authController.isLoading.value
                    ? CircularProgressIndicator()
                    : InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            authController.login(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: customButton(buttonName: "Login",),
                      ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(SignUpScreen());
                },
                child: Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


