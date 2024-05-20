import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:sukauang/Main/calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';


class historytransaction extends StatefulWidget {
  const historytransaction({super.key});

  @override
  State<historytransaction> createState() => _historytransactionState();
}

var search = "";

class _historytransactionState extends State<historytransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(right: 16.0, left: 16, top: 48),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Riwayat Transaksi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "JakartaSans"),
              ),
              SizedBox(
                width: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 6.0,
                          top: 6.0,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 24.0, right: 16.0),
                          child: SvgPicture.asset(
                            "images/searchicon.svg",
                            width: 24.0,
                          ),
                        ),
                        hintText: ("Makan Siang"),
                        hintStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,fontFamily: "JakartaSans",
                            color: HexColor("6B7280")),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: HexColor("#F3F4F6"),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  GestureDetector(
                    onTap: () {
                      Get.to(calendar());
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor("E5E7EB")),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "images/filter.svg",
                            width: 16.0,
                          ),
                          Text(
                            "Filter",
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,fontFamily: "JakartaSans",
                                color: HexColor("214F3B")),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0,),
                        Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  riwayatTransaksi(
                      iconAsset: "images/money.png",
                      title: "Pemasukan",
                      date: "12-Des-2023",
                      amount: "Rp 2.000.0000",
                      hexColor: "214F3B"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/piggybank.png",
                      title: "Pengeluaran",
                      date: "17-Sep-2023",
                      amount: "- Rp 2.000.0000",
                      hexColor: "DC2626"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/money.png",
                      title: "Pemasukan",
                      date: "12-Des-2023",
                      amount: "Rp 2.000.0000",
                      hexColor: "214F3B"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/piggybank.png",
                      title: "Pengeluaran",
                      date: "17-Sep-2023",
                      amount: "- Rp 2.000.0000",
                      hexColor: "DC2626"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/money.png",
                      title: "Pemasukan",
                      date: "12-Des-2023",
                      amount: "Rp 2.000.0000",
                      hexColor: "214F3B"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/piggybank.png",
                      title: "Pengeluaran",
                      date: "17-Sep-2023",
                      amount: "- Rp 2.000.0000",
                      hexColor: "DC2626"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/money.png",
                      title: "Pemasukan",
                      date: "12-Des-2023",
                      amount: "Rp 2.000.0000",
                      hexColor: "214F3B"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/piggybank.png",
                      title: "Pengeluaran",
                      date: "17-Sep-2023",
                      amount: "- Rp 2.000.0000",
                      hexColor: "DC2626"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/money.png",
                      title: "Pemasukan",
                      date: "12-Des-2023",
                      amount: "Rp 2.000.0000",
                      hexColor: "214F3B"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/piggybank.png",
                      title: "Pengeluaran",
                      date: "17-Sep-2023",
                      amount: "- Rp 2.000.0000",
                      hexColor: "DC2626"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/money.png",
                      title: "Pemasukan",
                      date: "12-Des-2023",
                      amount: "Rp 2.000.0000",
                      hexColor: "214F3B"),
                  SizedBox(
                    height: 8.0,
                  ),
                  riwayatTransaksi(
                      iconAsset: "images/piggybank.png",
                      title: "Pengeluaran",
                      date: "17-Sep-2023",
                      amount: "- Rp 2.000.0000",
                      hexColor: "DC2626"),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            )),],),
            
      ),
    );
  }
}



Widget riwayatTransaksi(
    {
    required iconAsset,
    required title,
    required date,
    required amount,
    required hexColor
    }) {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
    decoration: BoxDecoration(
      color: HexColor("E8FFE4"),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconAsset,
              width: 48,
            ),
            SizedBox(
              width: 8.0,
            ),
            SizedBox(
              width: 16.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold,fontFamily: "JakartaSans"),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10.0,fontFamily: "JakartaSans",
                  ),
                ),
              ],
            )
          ],
        ),
        Text(
          amount,
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,fontFamily: "JakartaSans",
              color: HexColor(hexColor)),
        ),
      ],
    ),
  );
}

