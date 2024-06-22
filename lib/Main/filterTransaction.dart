import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sukauang/Main/historytransaction.dart';


class filter extends StatefulWidget {
  const filter({Key? key}) : super(key: key);

  @override
  State<filter> createState() => _filterState();
}

class _filterState extends State<filter> {
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();



  bool incomeTypeIndex = false;
  bool expenseTypeIndex = false;

  

  void _onIncomeContainerTapped() {
    setState(() {
      incomeTypeIndex = !incomeTypeIndex; 
    });
  }

  void _onExpenseContainerTapped() {
    setState(() {
      expenseTypeIndex = !expenseTypeIndex;
    });
  }

    Future<void> _selectstartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
            builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.white, // Ganti warna primer
            colorScheme: ColorScheme.light(
                primary: HexColor("4FAF5A")), // Ganti skema warna
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Ganti gaya teks tombol
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        startDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

      Future<void> _selectendDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
            builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.white, // Ganti warna primer
            colorScheme: ColorScheme.light(
                primary: HexColor("4FAF5A")), // Ganti skema warna
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Ganti gaya teks tombol
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        endDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _saveDateToSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('startDatee', startDate.text);
  await prefs.setString('endDatee', endDate.text);
}

  final historytransaction transactionPage = historytransaction();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                          "Filter Tanggal",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "JakartaSans",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Text(
                  "Tanggal Awal",
                  style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: startDate,
                  readOnly: true,
                  onTap: () =>_selectstartDate(context),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    hintText: "2000-01-01",
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "JakartaSans",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: HexColor("#F3F4F6"),
                  ),
                ),
                SizedBox(height: 32.0),
                Text(
                  "Tanggal Akhir",
                  style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  readOnly: true,
                  controller: endDate,
                  onTap: () => _selectendDate(context),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    hintText: "2040-12-12",
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      fontFamily: "JakartaSans",
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
                SizedBox(height: 32.0),
              ],
            ),
            ElevatedButton(
              onPressed: ()async {
              await _saveDateToSharedPreferences();
                Get.back();

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("4FAF5A"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: Text(
                  "Simpan",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "JakartaSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
