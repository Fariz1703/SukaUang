import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sukauang/Main/BottomNavbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sukauang/GetApi/updateTransaction.dart';
import 'package:sukauang/GetApi/deleteTransaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sukauang/Main/historytransaction.dart';

class update extends StatefulWidget {
  @override
  State<update> createState() => _updateState();
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

OverlayEntry? _overlayEntry;
final TextEditingController _amountController = TextEditingController();
final TextEditingController _dateController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final deletetransaction _deletetransaction = deletetransaction();
final updatetransaction _updatetransaction = updatetransaction();
final updatetransaction _type = updatetransaction();
 bool _isButtonDisabledup = true;
  bool _isButtonDisableddel = true;

String id = "";

class _updateState extends State<update> {
  int transactionTypeIndex = 0;
  String type = "";

  Future<void> back() async {
    setState(() {
      Get.off(bottomnavbar());
    });
  }

  Future<void> deletedata()async{
      final prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
    prefs.remove("amount");
    prefs.remove("date");
    prefs.remove("description");
    prefs.remove("type");
    _amountController.clear();
    _dateController.clear();
    _descriptionController.clear();
  }

  Future<void> getData() async {
    
    final prefs = await SharedPreferences.getInstance();
    String? idd = prefs.getString("id");
    int? jumlah = prefs.getInt("amount");
    String jumlahString = jumlah?.toString() ?? '';
    String? tanggal = prefs.getString("date");
    String? keterangan = prefs.getString("description");
    String? tipe = prefs.getString("type");

    if (idd != null &&
        jumlah != null &&
        tanggal != null &&
        keterangan != null &&
        type != null) {
      setState(() {
        id = idd;
        _amountController.text = jumlahString;
        _dateController.text = tanggal;
        _descriptionController.text = keterangan;
        if (tipe == "income") {
          setState(() {
            transactionTypeIndex = 0;
          });
        } else {
          setState(() {
            transactionTypeIndex = 1;
          });
        }
      });
    }
  }

  



  void _onContainerTapped(int index) {
    if (mounted) {
      setState(() {
        transactionTypeIndex = index;
      });
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
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
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _handledelSubmit() async {
    setState(() {
      type = transactionTypeIndex == 0 ? "income" : "expense";
      showProgress(context, true);
    });
    setState(() {
      showProgress(context, true);
    });

    try {
      final response = await _deletetransaction.delete(
        id,
      );

      if (response.success == 'true') {
        await deletedata();
        Get.off(historytransaction());;
        setState(() {
          _isButtonDisableddel=true;
        });
        
      } else {
        showFloatingText(context, response.message);
                setState(() {
          _isButtonDisableddel=true;
        });
      }
    } catch (error) {
      showFloatingText(context, 'Error: $error');
              setState(() {
          _isButtonDisableddel=true;
        });
    } finally {
      showProgress(context, false);
              setState(() {
          _isButtonDisableddel=true;
        });
    }
  }

  void _handleSubmit() async {
    setState(() {
      type = transactionTypeIndex == 0 ? "income" : "expense";
      showProgress(context, true);
    });

    try {
      final response = await _updatetransaction.update(
        id,
        _amountController.text,
        _dateController.text,
        type,
        _descriptionController.text,
      );

      if (response.success == 'true') {
await deletedata();
        Get.off(historytransaction());
                setState(() {
          _isButtonDisabledup=true;
        });
      } else {
        showFloatingText(context, response.message);
                setState(() {
          _isButtonDisabledup=true;
        });
      }
    } catch (error) {
      showFloatingText(context, 'Error: $error');
              setState(() {
          _isButtonDisabledup=true;
        });
    } finally {
      showProgress(context, false);
              setState(() {
          _isButtonDisabledup=true;
        });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(right: 16, left: 16, top: 48),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() async{
                          await deletedata();
                                            Get.off(back());
                        });
      

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
                          "Ubah Transaksi",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "JakartaSans",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50.0),
                Text(
                  "Nominal",
                  style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                          hintText: "Nominal",
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
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Text(
                  "Tanggal Transaksi",
                  style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
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
                          hintText: "Pilih Tanggal",
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
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Text(
                  "Deskripsi",
                  style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                          hintText: "Isi Deskripsi Singkat",
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
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Text(
                  "Jenis Transaksi",
                  style: TextStyle(fontSize: 12, fontFamily: "JakartaSans"),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onContainerTapped(0),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 20.25, top: 16, bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: transactionTypeIndex == 0
                                  ? HexColor("A5DD9B")
                                  : HexColor("E5E7EB"),
                            ),
                            color: transactionTypeIndex == 0
                                ? HexColor("E8FFE4")
                                : HexColor("FFFFFF"),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/piggybank.png",
                                width: 32,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "Pendapatan",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "JakartaSans",
                                  color: transactionTypeIndex == 0
                                      ? HexColor("214F3B")
                                      : HexColor("000000"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onContainerTapped(1),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 20.25, top: 16, bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: transactionTypeIndex == 1
                                  ? HexColor("A5DD9B")
                                  : HexColor("E5E7EB"),
                            ),
                            color: transactionTypeIndex == 1
                                ? HexColor("E8FFE4")
                                : HexColor("FFFFFF"),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/money.png",
                                width: 32,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "Pengeluaran",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "JakartaSans",
                                  color: transactionTypeIndex == 1
                                      ? HexColor("214F3B")
                                      : HexColor("000000"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isButtonDisableddel? (){
                          _handledelSubmit();
                          _isButtonDisableddel=false;
                        }:null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("4FAF5A"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Hapus",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "JakartaSans"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabledup? (){setState(() {
                          _isButtonDisabledup=false;
                          _handleSubmit();
                        });}:null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("4FAF5A"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Ubah",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "JakartaSans"),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
