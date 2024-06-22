import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPWW {
  Future<LoginResponse> ResetPW(String Email,String Password, String otp) async {
    final response = await http.post(
      Uri.parse(
          'https://sukauang.online/api/users/reset-password'), // Ganti dengan URL API Anda
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept' :'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': Email,
        'password': Password,
        'otp':otp,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception('Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    }
    ;
  }
}

// mengambil data respon
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
