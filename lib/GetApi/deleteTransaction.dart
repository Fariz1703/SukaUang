import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class deletetransaction {
  Future<deleteResponse> delete(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.delete(
      Uri.parse(
          'https://sukauang.online/api/ledgers/$id'), // Ganti dengan URL API Anda
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return deleteResponse
          .fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(
          'Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    }
  }
}

class deleteResponse {
  final String success;
  final String message;

  const deleteResponse({
    required this.success,
    required this.message,
  });

  factory deleteResponse.fromJson(Map<String, dynamic> json) {
    return deleteResponse(
      success: json['success'] as String,
      message: json['message'] as String,
    );
  }
}
