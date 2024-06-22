import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class getOTPPostS {
  Future<LoginResponse> verifyOTPS(String email,String otps) async {
    final response = await http.post(
      Uri.parse(
          'https://sukauang.online/api/otps/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
                'accept' :'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'name': "reset_password",
        'otp' : otps,
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
    Future<void> saveOTP(String otps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('otps', otps);
  }
    Future<Map<String, String>> loadOTP() async {
    final prefs = await SharedPreferences.getInstance();
    final otps = prefs.getString('otps') ?? '';
    
    return {
      'otps': otps,
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
