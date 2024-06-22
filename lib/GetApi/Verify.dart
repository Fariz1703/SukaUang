import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class getOTPPost {
  Future<LoginResponse> verifyOTP(String otp) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse(
          'https://sukauang.online/api/users/verify'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
        'accept' :'application/json',
      },
      body: jsonEncode(<String, String>{
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception('Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    }
    
      }
    Future<void> saveOTP(String otp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('otp', otp);
  }
    Future<Map<String, String>> loadOTP() async {
    final prefs = await SharedPreferences.getInstance();
    final otp = prefs.getString('otp') ?? '';
    
    return {
      'otp': otp,
    };
  }
}

class LoginResponse {
  final String success;
  final String message;

  const LoginResponse({
    required this.success,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as String,
      message: json['message'] as String,
    );
  }
}
