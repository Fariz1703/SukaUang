import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class updatetransaction {
  Future<updateResponse> update(
      String id, String amount, String date,String type, String description) async {

    int _amount = int.parse(amount);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.patch(
      Uri.parse(
          'https://sukauang.online/api/ledgers/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
                'accept' :'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "amount": _amount,
        'date': date,
        'type':type, 
        "description": description,
      }),
    );

    print(response);
    print( jsonEncode(<String, dynamic>{
        "amount": _amount,
        'date': date,
        'type':type, 
        "description": description
      }));
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return updateResponse
          .fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception('Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    }
  }
}

// mengambil data respon
class updateResponse {
  final String success;
  final String message;

  const updateResponse({
    required this.success,
    required this.message,
  });

  factory updateResponse.fromJson(Map<String, dynamic> json) {
    return updateResponse(
      success: json['success'] as String,
      message: json['message'] as String,
    );
  }
}
