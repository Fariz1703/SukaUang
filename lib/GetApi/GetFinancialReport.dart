import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GetApiFinancialReport {
  Future<GetResponseFinancialReport> getFinancialReport() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('https://sukauang.online/api/ledgers/financial-report'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GetResponseFinancialReport.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(
          'Error ${response.statusCode}: ${errorResponse['message'] ?? 'Unknown error occurred'}');
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> saveFinancialReport(int remainingMoney, int currentMonthExpense,
      int currentMonthIncome) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingMoney', remainingMoney);
    await prefs.setInt('currentMonthExpense', currentMonthExpense);
    await prefs.setInt('currentMonthIncome', currentMonthIncome);
  }

  Future<Map<String, int>> loadFinancialReport() async {
    final prefs = await SharedPreferences.getInstance();
    int remainingMoney = prefs.getInt('remainingMoney') ?? 0;
    int currentMonthExpense = prefs.getInt('currentMonthExpense') ?? 0;
    int currentMonthIncome = prefs.getInt('currentMonthIncome') ?? 0;

    return {
      'remainingMoney': remainingMoney,
      'currentMonthExpense': currentMonthExpense,
      'currentMonthIncome': currentMonthIncome,
    };
  }
}

class GetResponseFinancialReport {
  final Map<String, dynamic> data;

  const GetResponseFinancialReport({
    required this.data,
  });

  factory GetResponseFinancialReport.fromJson(Map<String, dynamic> json) {
    return GetResponseFinancialReport(
      data: json["data"] as Map<String, dynamic>,
    );
  }

  int get remainingMoney => data['remainingMoney'] as int;
  int get currentMonthExpense => data['currentMonthExpense'] as int;
  int get currentMonthIncome => data['currentMonthIncome'] as int;
}
