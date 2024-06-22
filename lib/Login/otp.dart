import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:sukauang/GetApi/Verify.dart';
import 'package:sukauang/GetApi/login.dart';
import 'package:sukauang/GetApi/sendverification.dart';
import 'package:sukauang/Login/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sukauang/Main/BottomNavbar.dart';
import 'package:sukauang/Main/home.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:shared_preferences/shared_preferences.dart';

class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _otpState();
}

final sendverify _sendverify = sendverify();
final getOTPPost _otpPost = getOTPPost();
final getApiPost _apiPost = getApiPost();
final datauser = _apiPost.loadUserData();
TextEditingController _pinController = TextEditingController();

class _otpState extends State<otp> {
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

  Future<void> removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("otp");
  }

  void _handleSubmit() async {
    setState(() {
      showProgress(context, true);
    });

    try {
      final response = await _otpPost.verifyOTP(
        _pinController.text,
      );

      if (response.success == 'true') {
        Get.off(bottomnavbar());
        showFloatingText(context,"Akun telah terverifikasi");
        removeData();
        _pinController.clear();
      } else {
        showFloatingText(context, response.message);
                _pinController.clear();
      }
    } catch (error) {
      showFloatingText(context, 'Error: $error');
              _pinController.clear();
    } finally {
      showProgress(context, false);
              _pinController.clear();
    }
  }

  OverlayEntry? _overlayEntry;
  final defaultpintheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: TextStyle(fontSize: 24, fontFamily: "JakartaSans"),
      decoration: BoxDecoration(
          color: HexColor("E8FFE4"),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.transparent)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Map<String, String>>(
            future: datauser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No user data found'));
              } else {
                final userData = snapshot.data!;
                return Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 48),
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Verifikasi Akun",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "JakartaSans"),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                                Text(
                                  "Masukkan 6 digit kode OTP yang dikirimkan melalui email ",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: HexColor("6B7280"),
                                      fontFamily: "JakartaSans"),
                                ),
                                Text(
                                  "${userData["email"]}",
                                  softWrap: true,
                                                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: HexColor("214F3B"),
                            fontFamily: "JakartaSans"),
                                ),
                            SizedBox(
                              height: 64.0,
                            ),
                            Center(
                              child: Container(
                                child: Pinput(
                                  length: 6,
                                  controller: _pinController,
                                  defaultPinTheme: defaultpintheme,
                                  focusedPinTheme: defaultpintheme.copyWith(
                                      decoration:
                                          defaultpintheme.decoration!.copyWith(
                                    color: HexColor("E8FFE4"),
                                    border:
                                        Border.all(color: HexColor("4FAF5A")),
                                  )),
                                  onCompleted: (Value) {
                                    _handleSubmit();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tidak Terima Email?(",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: HexColor("6B7280"),
                                      fontFamily: "JakartaSans"),
                                ),
                                Countdown(
                                  seconds: 260,
                                  build: (BuildContext context, double time) =>
                                      Text(
                                    time.toStringAsFixed(0),
                                    style: TextStyle(
                                      fontSize: 12, // Ukuran teks
                                      color: HexColor("6B7280"),
                                    ),
                                  ),
                                  interval: Duration(seconds: 1),
                                  onFinished: () {
                                    _isButtonDisabled = false;
                                  },
                                ),
                                Text(
                                  ")",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: HexColor("6B7280"),
                                      fontFamily: "JakartaSans"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: _isButtonDisabled
                                    ? null
                                    : () {
                                        _sendverify.Sendverify();
                                      },
                                child: Text(
                                  "Kirim Email",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: "JakartaSans",
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              }
            }));
  }
}
