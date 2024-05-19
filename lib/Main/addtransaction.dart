import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:sukauang/Main/BottomNavbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class addtransaction extends StatefulWidget {
  @override
  State<addtransaction> createState() => _addtransactionState();
}

var nominal = "";
var tanggal_Transaksi = "";
var Deksripsi = "";

class _addtransactionState extends State<addtransaction> {
  int jenistransaksiindex = 0;

  void _onContainerTapped(int index) {
    setState(() {
      jenistransaksiindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.off(bottomnavbar());
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
                    "Tambah Transaksi",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "JakartaSans"),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Nomial",
              style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
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
                        nominal = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                      hintText: ("Tanggal Transaksi"),
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
            Text(
              "Tanggal Transasksi",
              style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
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
                        tanggal_Transaksi = value;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 24.0, right: 16.0),
                        child: SvgPicture.asset(
                          "images/calendar.svg",
                          width: 24.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                      hintText: ("6 Sep 2023"),
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
            Text(
              "Deksripsi",
              style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
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
                        Deksripsi = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                      hintText: ("Isi Deksripsi Singkat"),
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
            Text(
              "Jenis Transaksi",
              style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: GestureDetector(
                onTap: () => _onContainerTapped(0),
                child: Container(
                  padding: EdgeInsets.only(left: 20.25, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: jenistransaksiindex == 0
                          ? HexColor("A5DD9B")
                          : HexColor("E5E7EB"),
                    ),
                    color: jenistransaksiindex == 0
                        ? HexColor("E8FFE4")
                        : HexColor("FFFFFF"),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/piggybank.png",
                        width: 48,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Pendapatan",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: "JakartaSans",
                          color: jenistransaksiindex == 0
                              ? HexColor("214F3B")
                              : HexColor("000000"),
                        ),
                      )
                    ],
                  ),
                ),
              )),
              SizedBox(width: 16.0),
              Expanded(
                  child: GestureDetector(
                onTap: () => _onContainerTapped(1),
                child: Container(
                  padding: EdgeInsets.only(left: 20.25, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: jenistransaksiindex == 1
                          ? HexColor("A5DD9B")
                          : HexColor("E5E7EB"),
                    ),
                    color: jenistransaksiindex == 1
                        ? HexColor("E8FFE4")
                        : HexColor("FFFFFF"),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/money.png",
                        width: 48,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Pendapatan",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "JakartaSans",
                          fontWeight: FontWeight.bold,
                          color: jenistransaksiindex == 1
                              ? HexColor("214F3B")
                              : HexColor("000000"),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ]),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("4FAF5A"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: Text(
                  "Tambah",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "JakartaSans"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
