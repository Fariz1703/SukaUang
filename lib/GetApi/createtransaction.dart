import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class createtransaction{
  Future<createResponse> create(String amount, String date, String type, String description) async {
    int _amount=int.parse(amount);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
      final response = await http.post(
      Uri.parse('https://sukauang.online/api/ledgers'),
      headers:<String, String> {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
                'accept' :'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "amount": _amount,
        'date':date,
        'type':type,
        "description":description
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <300) {
      return createResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception('Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    } 
  }
}
class createResponse {
  final String success;
  final String message;

  const createResponse({
    required this.success,
    required this.message,
  });

  factory createResponse.fromJson(Map<String, dynamic> json) {
    return createResponse(
      success: json['success'] as String,
      message: json['message'] as String,
    );
  }
}

