import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API_services/apiServices.dart';
import '../API_services/tokenStorage.dart';
import '../View/Auth Screens/loginScreen.dart';
import '../View/User/UserDashboard.dart';
import '../View/admin/AdminDashboard.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
//REGISTER USER/ADMIN
  Future<void> registerUser(
      String username, String email, String password,String role
      ) async {
    try {
      isLoading.value = true;

      final response = await ApiService.register(
        username: username,
        email: email,
        password: password,
        role: role,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Registration successful");
        Get.back();
      } else {
        Get.snackbar("Error", data['message'] ?? "Registration failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

//auth login user/admin

  var role = ''.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    final result = await ApiService.login(email, password);

    if (result != null) {
      await Storage.saveAuth(result.token, result.role);
      role.value = result.role;

      if (result.role == 'admin') {
        Get.offAll(() => AdminDashboard());
      } else {
        Get.offAll(() => UserDashboard());
      }
    } else {
      Get.snackbar("Error", "Invalid credentials");
    }

    isLoading.value = false;
  }

//check the login from  role
  Future<void> checkLogin() async {
    final token = await Storage.getToken();
    final savedRole = await Storage.getRole();

    if (token != null && savedRole != null) {
      if (savedRole == 'admin') {
        Get.offAll(() => AdminDashboard());
      } else {
        Get.offAll(() => UserDashboard());
      }
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  // logout

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.off(() => LoginScreen());
  }
}
