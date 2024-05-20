import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

var search = "";
var sisaUang = "Rp 2.000.000";
var pendapatan = "2.000.000";
var pengeluaran = "2.000.000";

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 12.0, left: 12.0, bottom: 6.0, top: 6.0),
                  child: SvgPicture.asset(
                    "images/logo.svg",
                    width: 32,
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
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
                          fontFamily: "JakartaSans",
                          fontWeight: FontWeight.bold,
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
              ],
            ),
            SizedBox(height: 48),
            Text(
              "Sisa Uang Tersedia",
              style: TextStyle(fontSize: 10, fontFamily: "JakartaSans"),
            ),
            SizedBox(height: 4),
            Text(
              sisaUang,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "JakartaSans"),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(107, 114, 128, 100)),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pendapatan Bulan ini",
                        style: TextStyle(
                            fontSize: 10,
                            color: HexColor("6B7280"),
                            fontFamily: "JakartaSans"),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "images/arrowtop.svg",
                            width: 24,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            sisaUang,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: HexColor("16A34A"),
                                fontFamily: "JakartaSans"),
                          )
                        ],
                      )
                    ],
                  ),
                )),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(107, 114, 128, 100)),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pengeluaran Bulan ini",
                        style: TextStyle(
                            fontSize: 10,
                            color: HexColor("6B7280"),
                            fontFamily: "JakartaSans"),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "images/arrowbottom.svg",
                            width: 24,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            pengeluaran,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: HexColor("DC2626"),
                                fontFamily: "JakartaSans"),
                          )
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Riwayat Transaksi",
                  style: TextStyle(fontSize: 16.0, fontFamily: "JakartaSans"),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: "JakartaSans",
                        fontWeight: FontWeight.bold,
                        color: HexColor("6B7280")),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
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
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

Widget riwayatTransaksi(
    {required iconAsset,
    required title,
    required date,
    required amount,
    required hexColor}) {
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
                  style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "JakartaSans"),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: "JakartaSans",
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
              fontFamily: "JakartaSans",
              fontWeight: FontWeight.bold,
              color: HexColor(hexColor)),
        ),
      ],
    ),
  );
}
