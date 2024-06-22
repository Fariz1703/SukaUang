import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// mengirim email dan password
class getApiPost{
  Future<LoginResponse> loginUser(String Email, String Password) async {
      final response = await http.post(
      Uri.parse('https://sukauang.online/api/users/login'), // Ganti dengan URL API Anda
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
                'accept' :'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': Email,
        'password':Password,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception('Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    };
    
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
    final token = prefs.getString('token') ?? ''; 

    return {
      'name': name,
      'email': email,
      'token': token,
    };
  }
}

// mengambil data respon
class LoginResponse {
  final String success;
  final String message;
  final Map<String, dynamic> data;

  const LoginResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as String,
      message: json['message'] as String,
      data: json["data"] as Map<String, dynamic>,
    );
  }

  String get id => data['id'] as String;
  String get name => data['name'] as String;
  String get email => data['email'] as String;
  String get token => data['access_token'] as String;
  String? get email_verified_at => data["email_verified_at"] as String?;
}
