
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:sukauang/Login/login.dart';
import 'package:sukauang/Main/editprofile.dart';
import 'package:flutter_svg/flutter_svg.dart';

var username = "Fariz";
var email = "Fariz@www.com";

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  child: Image.asset(
                    "images/profilepage.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "JakartaSans"),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                            fontSize: 10.0, color: HexColor("6B7280"),fontFamily: "JakartaSans"),
                      ),
                      SizedBox(
                        height: 57.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(editprofile());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "images/editprofile.svg",
                                      height: 24,
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(fontSize: 14,fontFamily: "JakartaSans"),
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  "images/arrowright.svg",
                                  width: 24,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "images/heart.svg",
                                      height: 24,
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Text(
                                      "Rate Us",
                                      style: TextStyle(fontSize: 14,fontFamily: "JakartaSans"),
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  "images/arrowright.svg",
                                  width: 24,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "images/supportus.svg",
                                      height: 24,
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Text(
                                      "Support Us",
                                      style: TextStyle(fontSize: 14,fontFamily: "JakartaSans"),
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  "images/arrowright.svg",
                                  width: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 65.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.off(login());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("DC2626"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Keluar",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                                ,fontFamily: "JakartaSans"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 16,
              top: 80,
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 84,
              child: ClipOval(
                child: Container(
                  width: 76.0,
                  height: 76.0,
                  child: Image.asset(
                    "images/profil.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
