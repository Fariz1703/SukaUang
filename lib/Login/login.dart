import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:sukauang/Login/createaccount.dart';
import 'package:sukauang/Login/forgetpassword.dart';
import 'package:sukauang/Main/BottomNavbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

var email = "";
var password = "";

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 48),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:
                Image.asset(
                  "images/loginpage.png",
                  height: 320,
                  width: 320,
                ),
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,fontFamily: "JakartaSans"),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: InputDecoration(
                        
                        contentPadding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 24.0, right: 16.0),
                          child: SvgPicture.asset(
                            "images/mail.svg",
                            width: 24.0,
                          ),
                        ),
                        hintText: ("Email"),
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "JakartaSans"
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: HexColor("#F3F4F6"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 24.0, right: 16.0),
                          child: SvgPicture.asset(
                            "images/password.svg",
                            width: 24.0,
                          ),
                        ),
                        hintText: ("Password"),
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "JakartaSans"
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: HexColor("#F3F4F6"),
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(forgetpassword());
                    },
                    child: Text(
                      "Lupa Password?",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: HexColor("214F3B")
                          ,fontFamily: "JakartaSans"),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Tidak Punya Akun? ",
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w300,fontFamily: "JakartaSans"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(createaccount());
                        },
                        child: Text(
                          "Buat Akun",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: HexColor("214F3B")
                              ,fontFamily: "JakartaSans"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.off(bottomnavbar());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4FAF5A"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                        ,fontFamily: "JakartaSans"),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
