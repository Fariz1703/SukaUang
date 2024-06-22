import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sukauang/Login/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sukauang/GetApi/register.dart';
import 'package:sukauang/Login/otp.dart';

class createaccount extends StatefulWidget {
  const createaccount({super.key});

  @override
  State<createaccount> createState() => _createaccountState();
}

final registertransaction _registertransaction = registertransaction();
final TextEditingController username = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController confirmpassword = TextEditingController();
String passwordfinal = "";
OverlayEntry? _overlayEntry;
bool? _truefalse;
bool _isButtonDisabled = true;
bool _visibleButton = true;
bool _visibleButtonB = true;

class _createaccountState extends State<createaccount> {
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

  bool _password(BuildContext context) {
    if (password.text != confirmpassword.text) {
      showFloatingText(context, "Password tidak sama");
      return false;
    } else {
      passwordfinal = password.text;
      return true;
    }
  }

  void _handleSubmit() async {
    if (!_password(context)) {
      return;
    }

    showProgress(context, true);
    try {
      final response = await _registertransaction.register(
          username.text, email.text, passwordfinal);
      if (response.success == 'true') {
        username.clear();
        email.clear();
        password.clear();
        confirmpassword.clear();
        _registertransaction.saveUserData(
            response.name, response.email, response.token);
        showFloatingText(context,
            "Akun telah berhasil dibuat silakan melakukan verifikasi akun!");
        setState(() {
          _isButtonDisabled = true;
        });
        Get.off(otp());
      } else {
        showFloatingText(context, response.message);
        setState(() {
          _isButtonDisabled = true;
        });
      }
    } catch (error) {
      showFloatingText(context, 'Error: $error');
      setState(() {
        _isButtonDisabled = true;
      });
    } finally {
      showProgress(context, false);
      _isButtonDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 48),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "images/createaccount.png",
                  height: 340,
                ),
              ),
              Text(
                "Buat Akun",
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
                      controller: username,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 24.0, right: 16.0),
                          child: SvgPicture.asset(
                            "images/profile.svg",
                            width: 24.0,
                          ),
                        ),
                        hintText: ("Username"),
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
                      controller: email,
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
                      controller: password,
                      onChanged: (value) {},
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
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
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
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: confirmpassword,
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
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            IconButton(
                              icon: Icon(
                                _visibleButtonB
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: HexColor("6B7280"),
                              ),
                              onPressed: () {
                                setState(() {
                                  _visibleButtonB = !_visibleButtonB;
                                });
                              },
                            ),
                          ]),
                        ),
                        hintText: ("Konfirmasi Password"),
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
                      obscureText: _visibleButtonB,
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
                            fontWeight: FontWeight.w300,
                            fontFamily: "JakartaSans"),
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
                              color: HexColor("214F3B"),
                              fontFamily: "JakartaSans"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: _isButtonDisabled
                    ? () {
                        setState(() {
                          _isButtonDisabled = false;
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
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Buat Akun",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "JakartaSans"),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
