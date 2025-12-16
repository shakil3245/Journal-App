import 'dart:convert';

import 'package:get/get.dart';

import '../API_services/apiServices.dart';

class JournalController extends GetxController {
  final ApiService apiService = ApiService();


  var isLoading = false.obs;

  void createPost(String title, String description) async {
    isLoading.value = true;

    try {
      final response = await apiService.postData(title, description);
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Post created successfully');
      } else {
        Get.snackbar('Error', 'Failed to create post');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> deletePost(String postId) async {
    try {
      isLoading.value = true;
      final response = await apiService.deletePost(postId);

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar('Success', 'Post deleted successfully');


      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Error', error['message'] ?? 'Failed to delete post');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
