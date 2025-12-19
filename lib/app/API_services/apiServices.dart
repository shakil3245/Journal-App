import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journal/app/API_services/tokenStorage.dart';
import '../Model/authModel.dart';
import '../Model/journalModel.dart';
import '../Utils/appConstant.dart';



class ApiService {

  // registration user

  static Future<http.Response> register({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    final apiUrl = Uri.parse("${AppConstants.baseUrl}/api/auth/register");

    return await http.post(
      apiUrl,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
        "role": role,
      }),
    );
  }


  //login test

  static Future<LoginResponse?> login(String email, String password) async {
    final apiUrl = Uri.parse("${AppConstants.baseUrl}/api/auth/login");
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      return null;
    }
  }


  //edn

   Future<http.Response> fetchJournals() async {
    final token = await Storage.getToken();
    return await http.get(Uri.parse("${AppConstants.baseUrl}/api/journals"),
        headers: {
      'Authorization': 'Bearer $token',
    });

  }
  //post data
  Future<http.Response> postData(String title, String description) async {
    final token = await Storage.getToken();
    final url = Uri.parse('${AppConstants.baseUrl}/api/journals');

    return await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'content': description,
      }),
    );
  }

//delete data
  Future<http.Response> deletePost(String postId) async {
    final token = await Storage.getToken();
    final url = Uri.parse('${AppConstants.baseUrl}/api/journals/$postId');

    return await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }






}
