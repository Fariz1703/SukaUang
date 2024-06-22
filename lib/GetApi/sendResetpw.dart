import 'package:http/http.dart' as http;
import 'dart:convert';


class sendresetpw {
  Future<LoginResponse> sendresetPW(String email) async {
    final response = await http.post(
      Uri.parse(
          'https://sukauang.online/api/emails/reset-password-otp'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
                'accept' :'application/json',
      },
      body: jsonEncode(<String, String>{
        "email": email,
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
