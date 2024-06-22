import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sukauang/GetApi/GetAllTransaction.dart';
import 'package:sukauang/GetApi/GetFinancialReport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sukauang/Main/BottomNavbar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Transaction> transactions = [];
  TextEditingController search = TextEditingController();
  int sisaUang = 0;
  int pendapatan = 0;
  int pengeluaran = 0;
  String keterangan = "";

  List<Transaction> filterTransactionsByDescription(String searchText) {
    return transactions.where((transaction) => transaction.description.contains(searchText)).toList();
  }

  @override
  void initState() {
   performAsyncOperation();
    super.initState();
    fetchData();
    fetchDataALL();
    search.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    search.removeListener(_onSearchChanged);
    search.dispose();
    super.dispose();
  }

    void performAsyncOperation() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void _onSearchChanged() {
    setState(() {});
  }

  String formatNumber(int number) {
    final formatter = NumberFormat('#,##0', 'id_ID'); // Use 'id_ID' for Indonesian format
    return formatter.format(number);
  }

  Future<void> fetchData() async {
    GetApiFinancialReport api = GetApiFinancialReport();
    try {
      GetResponseFinancialReport response = await api.getFinancialReport();
      setState(() {
        sisaUang = response.remainingMoney;
        pendapatan = response.currentMonthIncome;
        pengeluaran = response.currentMonthExpense;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchDataALL() async {
    GetApiAllTransaction api = GetApiAllTransaction();
    try {
      GetResponseAllTransaction response = await api.getAlltransction("default", "default");
      setState(() {
        transactions = response.transactions;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> filteredTransactions = search.text.isEmpty
        ? transactions
        : filterTransactionsByDescription(search.text);

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
                    right: 12.0,
                    left: 12.0,
                    bottom: 6.0,
                  ),
                  child: SvgPicture.asset(
                    "images/logo.svg",
                    width: 40,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: search,
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
                      hintText: "Makan Siang",
                      hintStyle: TextStyle(
                        fontSize: 12.0,
                        fontFamily: "JakartaSans",
                        fontWeight: FontWeight.bold,
                        color: HexColor("6B7280"),
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
            SizedBox(height: 48),
            Text(
              "Sisa Uang Tersedia",
              style: TextStyle(fontSize: 10, fontFamily: "JakartaSans"),
            ),
            SizedBox(height: 4),
            Text(
              "Rp ${formatNumber(sisaUang).toString()}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "JakartaSans",
              ),
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pendapatan Bulan ini",
                          style: TextStyle(
                            fontSize: 10,
                            color: HexColor("6B7280"),
                            fontFamily: "JakartaSans",
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "images/arrowtop.svg",
                              width: 24,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              "Rp ${formatNumber(pendapatan).toString()}",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: HexColor("16A34A"),
                                fontFamily: "JakartaSans",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(107, 114, 128, 100)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pengeluaran Bulan ini",
                          style: TextStyle(
                            fontSize: 10,
                            color: HexColor("6B7280"),
                            fontFamily: "JakartaSans",
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "images/arrowbottom.svg",
                              width: 24,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              "Rp ${formatNumber(pengeluaran).toString()}",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: HexColor("DC2626"),
                                fontFamily: "JakartaSans",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Riwayat Transaksi",
                  style: TextStyle(fontSize: 16.0, fontFamily: "JakartaSans"),
                ),
                GestureDetector(
                  onTap: () {
                    changeIndex(1);
                  },
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: "JakartaSans",
                      fontWeight: FontWeight.bold,
                      color: HexColor("6B7280"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: transactions.isEmpty
                  ? Center(
                      child: Text(
                        "Memuat Transaksi",
                        style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: "JakartaSans",
                          fontWeight: FontWeight.bold,
                          color: HexColor("6B7280"),
                        ),
                      ),
                    )
                  : filteredTransactions.isEmpty
                      ? Center(
                          child: Text(
                            "Tidak ada transaksi ditemukan",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: "JakartaSans",
                              fontWeight: FontWeight.bold,
                              color: HexColor("6B7280"),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = filteredTransactions[index];

                            return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  child: riwayatTransaksi(
                                    iconAsset: transaction.type == "income"
                                        ? "images/piggybank.png"
                                        : "images/money.png",
                                    title: transaction.description,
                                    date: transaction.date,
                                    amount: transaction.type == "income"
                                        ? "+ Rp ${formatNumber(transaction.amount).toString()}"
                                        : "- Rp ${formatNumber(transaction.amount).toString()}",
                                    hexColor: transaction.type == "income"
                                        ? "16A34A"
                                        : "DC2626",
                                  ),
                                ));
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget riwayatTransaksi({
  required String iconAsset,
  required String title,
  required String date,
  required String amount,
  required String hexColor,
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
              width: 24,
            ),
            SizedBox(width: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "JakartaSans",
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: "JakartaSans",
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: HexColor(hexColor),
            fontFamily: "JakartaSans",
          ),
        ),
      ],
    ),
  );
}
