import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class registertransaction{
  Future<registerResponse> register(String name, String email, String password) async {
      final response = await http.post(
      Uri.parse('https://sukauang.online/api/users/register'), // Ganti dengan URL API Anda
      headers:<String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
        'accept' :'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        'email':email,
        'password':password,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <300) {
      return registerResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception('Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    } 
  }

    Future<void> saveUserData(String name, String email, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('token', token);
  }
    Future<Map<String, String>> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '';
    final email = prefs.getString('email') ?? '';
    final token = prefs.getString('token') ?? ''; // Muat token

    return {
      'name': name,
      'email': email,
      'token': token,
    };
  }
}

// mengambil data respon
class registerResponse{
  final String success;
  final String message;
  final Map<String, dynamic> data;

  const registerResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory registerResponse.fromJson(Map<String, dynamic> json) {
    return registerResponse(
      success: json['success'] as String,
      message: json['message'] as String,
      data: json["data"] as Map<String, dynamic>,
    );
  }

  String get id => data['id'] as String;
  String get name => data['name'] as String;
  String get email => data['email'] as String;
  String get token => data['access_token'] as String;
}

