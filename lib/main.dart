
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sukauang/Login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sukauang/Main/BottomNavbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await checkLoginStatus();
  runApp(MyApp(isLoggedIn: isLoggedIn));
  changeIndex(0);
}

Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ; 
  return token != null && token.isNotEmpty;
}


class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? bottomnavbar() : login(),
    );
  }
}
