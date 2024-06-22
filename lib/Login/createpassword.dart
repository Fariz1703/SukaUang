import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sukauang/GetApi/resetpw.dart';
import 'package:sukauang/Login/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class createpassword extends StatefulWidget {
  const createpassword({super.key});

  @override
  State<createpassword> createState() => _createpasswordState();
}

final ResetPWW _resetPWW = ResetPWW();
final TextEditingController password = TextEditingController();
final TextEditingController confirmpassword = TextEditingController();
String createpasswordfinal = "";
OverlayEntry? _overlayEntry;
bool? _truefalse;
bool _isButtonDisabled = true;
bool _visibleButton = true;
bool _visibleButtonB = true;

class _createpasswordState extends State<createpassword> {
  final ResetPWW _resetPWW = ResetPWW();
  String _Mail = "";
  String _Otps = "";

  @override
  void initState() {
    super.initState();
    getOTPS();
    _loadOTPS();
    getmail();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    String email = await getmail();
    setState(() {
      _Mail = email;
    });
  }

  Future<String> getmail() async {
    final prefs = await SharedPreferences.getInstance();
    final mail = prefs.getString('mail') ?? '';
    return mail;
  }

  Future<void> _DelEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('mail');
  }

  Future<void> _loadOTPS() async {
    String otps = await getOTPS();
    setState(() {
      _Otps = otps;
    });
  }

  Future<String> getOTPS() async {
    final prefs = await SharedPreferences.getInstance();
    final otps = prefs.getString('otps') ?? '';
    return otps;
  }

  Future<void> _Delotps() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('otps');
  }

  void _handleSubmit() async {
    if (!_password(context)) {
      return;
    }

    setState(() {
      showProgress(context, true);
    });
    try {
      final response =
          await _resetPWW.ResetPW(_Mail, createpasswordfinal, _Otps);

      if (response.success == 'true') {
        showFloatingText(context,"Password anda telah diperbaharui");
        Get.off(createpassword());
        _DelEmail();
        _Delotps();
        password.clear();
        confirmpassword.clear();
        setState(() {
          _isButtonDisabled = true;
        });
        Get.off(login());
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

  Future<void> removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("otp");
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
      showFloatingText(context, "Password anda tidak sama");
      return false;
    } else {
      createpasswordfinal = password.text;
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 48),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password Baru",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "JakartaSans"),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                "Silahkan memasukan password baru untuk akun anda",
                style: TextStyle(
                    fontSize: 12.0,
                    color: HexColor("6B7280"),
                    fontFamily: "JakartaSans"),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                            suffixIcon:
                                Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, 
                                  children: 
                                  [
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
                          suffixIcon:
                                Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Row(
                                    
                                    mainAxisSize: MainAxisSize.min, 
                                  
                                  children: 
                                  [
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
                height: 24.0,
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
                    "Lanjutkan",
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
