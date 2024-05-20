import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';



class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

var newname = "";
var newemail = "";

class _editprofileState extends State<editprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: 48.0, right: 16, left: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          "images/backarrow.svg",
                          width: 24.0,
                        ),
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: "JakartaSans"),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Name Pengguna",
                    style: TextStyle(fontSize: 12,fontFamily: "JakartaSans"),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              newname = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                            hintText: ("Masukan Nama"),
                            hintStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,fontFamily: "JakartaSans",
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
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 12,fontFamily: "JakartaSans"),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              newemail = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                            hintText: ("Masukan Email"),
                            hintStyle: TextStyle(
                              fontSize: 12.0,fontFamily: "JakartaSans",
                              fontWeight: FontWeight.bold,
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
                  ),SizedBox(height: 300,),
                                  ElevatedButton(
                  onPressed: () {
                    Get.back();
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
                      "Simpan",
                      style: TextStyle(
                          fontSize: 14.0,fontFamily: "JakartaSans",
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                ])));
  }
}
