import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sukauang/GetApi/sendResetpw.dart';
import 'package:sukauang/Login/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sukauang/Login/otppw.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({super.key});

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  final sendresetpw _sendresetpw = sendresetpw();
  OverlayEntry? _overlayEntry;
  TextEditingController _email = TextEditingController();
  bool _isButtonDisabled = true;

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

  Future<void> savemail(String mail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mail', mail);
  }

  void _handleSubmit() async {
    setState(() {
      showProgress(context, true);
    });
    try {
      final response = await _sendresetpw.sendresetPW(
        _email.text,
      );
      if (response.success == 'true') {
        showFloatingText(
            context, " Email Berhasil Terkirim, Silakan Cek Email Anda");
        savemail(_email.text);
        _email.clear();
        setState() {
          _isButtonDisabled = true;
        }
        Get.off(otppw());
      } else {
        showFloatingText(context, response.message);
        setState() {
          _isButtonDisabled = true;
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 48),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "images/forgetpassword.png",
                        height: 360,
                      ),
                    ),
                    Text(
                      "Lupa Password",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "JakartaSans"),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Masukkan email anda dan kami akan mengirimkan prosedur untuk mengubah kata sandi anda.",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: HexColor("6B7280"),
                          fontFamily: "JakartaSans"),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _email,
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      onPressed: _isButtonDisabled
                          ? () {
                              setState(() {
                                _handleSubmit();
                                _isButtonDisabled = false;
                              });
                            }
                          : null,
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
            )));
  }
}
