import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class sendverify {
  Future<verifyResponse> Sendverify() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse(
          'https://sukauang.online/api/emails/email-verification-otp'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
                'accept' :'application/json',
      },
    );

    if (response.statusCode == 200) {
      return verifyResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception('Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    }
  }
}

class verifyResponse {
  final String success;
  final String message;

  const verifyResponse({
    required this.success,
    required this.message,
  });

  factory verifyResponse.fromJson(Map<String, dynamic> json) {
    return verifyResponse(
      success: json['success'] as String,
      message: json['message'] as String,
    );
  }
}
