import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:sukauang/GetApi/sendverification.dart';
import 'package:sukauang/Login/createaccount.dart';
import 'package:sukauang/Login/forgetpassword.dart';
import 'package:sukauang/Login/otp.dart';
import 'package:sukauang/Main/BottomNavbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sukauang/GetApi/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  OverlayEntry? _overlayEntry;
  final sendverify _sendverify = sendverify();
  final getApiPost _apiPost = getApiPost();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();
  bool _isButtonDisabled = true;
  bool _visibleButton = true;

  void showProgress(BuildContext context, bool isLoading) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    if (isLoading) {
      if (_overlayEntry == null) {
        _overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        );
        overlay.insert(_overlayEntry!);
      }
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

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
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: HexColor("666666"),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "JakartaSans"),
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


  void _handleSubmit() async {
    setState(() {
      showProgress(context, true);
    });

    try {
      final response = await _apiPost.loginUser(Email.text, Password.text);
      if (response.success == 'true' && response.email_verified_at != null) {
        await _apiPost.saveUserData(response.name, response.email, response.token);
        Get.offAll(bottomnavbar());
        setState(() {
          _isButtonDisabled = true;
        });
        Email.clear();
        Password.clear();
      } else if (response.success == 'true' &&
          response.email_verified_at == null) {
        await _apiPost.saveUserData(response.name, response.email, response.token);
        _sendverify.Sendverify();
        showFloatingText(context, "Akun belum diverifikasi");
        Get.off(otp());
        setState(() {
          _isButtonDisabled = true;
        });
        Email.clear();
        Password.clear();
      } else {
        showProgress(context, false);

        setState(() {
          showFloatingText(context, response.message);
          _isButtonDisabled = true;
        });
      }
    } catch (error) {
      showFloatingText(context, 'Error: $error');
      setState() {
        _isButtonDisabled = true;
      }
    } finally {
      showProgress(context, false);
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "images/loginpage.png",
                    height: 320,
                    width: 320,
                  ),
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "JakartaSans"),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: Email,
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
                              fontFamily: "JakartaSans"),
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
                        controller: Password,
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
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: Icon(
                                  _visibleButton
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: HexColor("6B7280"),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _visibleButton = !_visibleButton;
                                  });
                                },
                              ),
                            ]),
                          ),
                          hintText: ("Password"),
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "JakartaSans"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: HexColor("#F3F4F6"),
                        ),
                        obscureText: _visibleButton,
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
                            color: HexColor("214F3B"),
                            fontFamily: "JakartaSans"),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Tidak Punya Akun? ",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300,
                              fontFamily: "JakartaSans"),
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
                                color: HexColor("214F3B"),
                                fontFamily: "JakartaSans"),
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
                  onPressed: _isButtonDisabled
                      ? () {
                          setState(() {
                            _isButtonDisabled = false;
                            showProgress(context, true);
                            _handleSubmit();
                          });
                        }
                      : null,
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
                          color: Colors.white,
                          fontFamily: "JakartaSans"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
