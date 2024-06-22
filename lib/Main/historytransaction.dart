import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:sukauang/Main/Update-Delete.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sukauang/Main/filterTransaction.dart';
import 'package:sukauang/GetApi/GetAllTransaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class historytransaction extends StatefulWidget {
  const historytransaction({Key? key});

  @override
  State<historytransaction> createState() => _historytransactionState();
}



class _historytransactionState extends State<historytransaction> {
  late List<Transaction> transactions = [];
  OverlayEntry? _overlayEntry;
  String type = "";
  int filtertypeindex = 0;
  int updatetypeindex = 0;
  TextEditingController search = TextEditingController();
  String startDate = "default";
  String endDate = "default";
  late String id = "";
  int transactionTypeIndex = 0;

  @override
  void initState() {
    delay();
    super.initState();
    fetchDataALL(startDate, endDate);
    filtertypeindex = 0;
    search.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    search.removeListener(_onSearchChanged);
    search.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
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

  List<Transaction> filterTransactionsByDescription(String searchText) {
    if (searchText.isEmpty) return transactions;
    final lowerCaseSearchText = searchText.toLowerCase();
    return transactions
        .where((transaction) =>
            transaction.description.toLowerCase().contains(lowerCaseSearchText))
        .toList();
  }

  String formatNumber(int number) {
    final formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(number);
  }

  Future<void> savedata(String id, int amount, String date, String description,
      String Type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setInt('amount', amount);
    await prefs.setString('date', date);
    await prefs.setString('description', description);
    await prefs.setString('type', type);
  }

  Future<void> change_id(String test)async {
    setState(() {
      id = test;
    });
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

  void performAsyncOperation() async {
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      setState(() {
        transactionTypeIndex = 0;
      });
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void delay() async {
    await Future.delayed(Duration(seconds: 1));
  }

  void _onContainerTapped(int index) {
    if (mounted) {
      setState(() {
        updatetypeindex = index;
      });
    }
  }

  Future<void> _getDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? startDate = prefs.getString('startDatee');
    String? endDate = prefs.getString('endDatee');
  }

  Future<void> fetchDataALL(String start, String end) async {
    GetApiAllTransaction api = GetApiAllTransaction();
    try {
      GetResponseAllTransaction response =
          await api.getAlltransction(start, end);
      setState(() {
        transactions = response.transactions;
      });
    } catch (e) {
      showFloatingText(context, 'Error fetching data: $e');
    }
  }

  void changeDateRange() async {
    final prefs = await SharedPreferences.getInstance();
    final startDatee = prefs.getString('startDatee');
    final endDatee = prefs.getString('endDatee');
    setState(() {
      startDate = startDatee.toString();
      endDate = endDatee.toString();
    });
    fetchDataALL(startDatee.toString(), endDatee.toString());
  }

  void handleFilter() async {
    await _getDataFromSharedPreferences();
    changeDateRange();

    setState(() {
      filtertypeindex = 1;
    });
  }

  void resetFilter() async {
    startDate = "default";
    endDate = "default";
    await fetchDataALL(startDate, endDate);

    setState(() {
      filtertypeindex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> filteredTransactions =
        filterTransactionsByDescription(search.text);

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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "JakartaSans",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      hintText: ("Makan Siang"),
                      hintStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "JakartaSans",
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
                SizedBox(
                  width: 8.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      filtertypeindex = 0;
                    });
                    Get.to(filter());
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor("E5E7EB")),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "images/filter.svg",
                            width: 16.0,
                          ),
                          Center(
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "JakartaSans",
                                color: HexColor("214F3B"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            GestureDetector(
                onTap: () {
                  if (filtertypeindex == 0) {
                    handleFilter();
                  } else {
                    resetFilter();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 20.25, top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: filtertypeindex == 1
                                ? HexColor("A5DD9B")
                                : HexColor("E5E7EB"),
                          ),
                          color: filtertypeindex == 1
                              ? HexColor("E8FFE4")
                              : HexColor("FFFFFF"),
                        ),
                        child: Center(
                          child: Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "JakartaSans",
                              color: filtertypeindex == 1
                                  ? HexColor("214F3B")
                                  : HexColor("000000"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 8.0,
            ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await change_id(transaction.id);
                                    await savedata(
                                        id,
                                        transaction.amount,
                                        transaction.date,
                                        transaction.description,
                                        transaction.type);
                                    final result = await Get.off(update());
                                    if (result == true) {
                                      initState();
                                    }
                                  },
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
              fontWeight: FontWeight.bold,
              fontFamily: "JakartaSans",
              color: HexColor(hexColor)),
        ),
      ],
    ),
  );
}
