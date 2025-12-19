import 'dart:convert';

import 'package:get/get.dart';

import '../API_services/apiServices.dart';
import '../Model/journalModel.dart';

class JournalController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  var journalsList = <JournalsModel>[].obs; // Reactive list

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchJournals();
  }

  @override

  void fetchJournals() async {
    try {
      isLoading.value = true;
      var response = await apiService.fetchJournals();
      isLoading.value = false;
      if (response.statusCode == 200) {
        journalsList.value = journalsModelFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Data fetch eror');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }

  }




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

  Future<void> deletePost(String id) async {
     final response =await apiService.deletePost(id);
     try{
       if (response.statusCode == 200 || response.statusCode == 204) {
         journalsList.removeWhere((journal) => journal.id.toString() == id);
         Get.snackbar('Success', 'Post deleted successfully');
         update();
       }else {
         final error = jsonDecode(response.body);
         Get.snackbar('Error', error['message'] ?? 'Failed to delete post');
       }
     }catch(err){
       Get.snackbar('Error', err.toString());
     }

  }
}
