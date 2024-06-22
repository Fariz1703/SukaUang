import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GetApiAllTransaction {
  Future<GetResponseAllTransaction> getAlltransction(
      String startDate, String endDate) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token is not available');
    }

    Uri uri;
    if (startDate == "default" && endDate == "default") {
      uri = Uri.parse('https://sukauang.online/api/ledgers');
    } else {
      uri = Uri.parse(
          'https://sukauang.online/api/ledgers?startDate=$startDate&endDate=$endDate');
    }

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return GetResponseAllTransaction.fromJson(data['data']);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(errorResponse['message'] ??
          'Unknown error occurred Code: ${response.statusCode}');
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

class Transaction {
  final String id;
  final String userId;
  final int amount;
  final String description;
  final String type;
  final String date;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.description,
    required this.type,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      description: json['description'],
      type: json['type'],
      date: json['date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class GetResponseAllTransaction {
  final List<Transaction> transactions;

  GetResponseAllTransaction({required this.transactions});

  factory GetResponseAllTransaction.fromJson(List<dynamic> json) {
    var transactions = json.map((item) => Transaction.fromJson(item)).toList();
    return GetResponseAllTransaction(transactions: transactions);
  }
}
