import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sukauang/Login/login.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: forgetpassword(),
    );
  }
}

class forgetpassword extends StatefulWidget {
  const forgetpassword({super.key});

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  var email = "";
  var password = "";

  void showFloatingText(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: MediaQuery.of(context).size.width * 0.2,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14.0,fontFamily: "JakartaSans"),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child:Image.asset(
                        "images/forgetpassword.png",
                        height: 360,
                      ),
                    ),
                    Text(
                      "Lupa Password",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold,fontFamily: "JakartaSans"),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Masukkan email anda dan kami akan mengirimkan prosedur untuk mengubah kata sandi anda.",
                      style:
                          TextStyle(fontSize: 12.0, color: HexColor("6B7280"),fontFamily: "JakartaSans"),
                    ),
                    SizedBox(
                      height: 16.0,
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
                                left: 16.0,
                                right: 16.0,
                                bottom: 8.0,
                                top: 8.0,
                              ),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 24.0, right: 16.0),
                                child:SvgPicture.asset(
                                  "images/mail.svg",
                                  width: 24.0,
                                ),
                              ),
                              hintText: ("Email"),
                              hintStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,fontFamily: "JakartaSans"
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
                      height: 32.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Sudah Punya Akun? ",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,fontFamily: "JakartaSans"
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.off(login());
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("214F3B"),fontFamily: "JakartaSans"
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showFloatingText(context, "Email Berhasil Terkirim");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("4FAF5A"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Kirim Email",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,fontFamily: "JakartaSans"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            )));
  }
}
