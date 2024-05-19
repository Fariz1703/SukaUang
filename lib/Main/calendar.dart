import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class calendar extends StatefulWidget {
  const calendar({super.key});

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  var jenistransaksiindex = 0;
  void _onContainerTapped(int index) {
    setState(() {
      jenistransaksiindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 56, right: 16, left: 16),
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
                      "Pilih Tanggal",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                        ,fontFamily: "JakartaSans"
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TableCalendar(
              focusedDay: today,
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 30),
              availableGestures: AvailableGestures.all,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (day) => isSameDay(day, today),
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: HexColor("16A34A"),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: HexColor("4FAF5A"),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Text(
              "Jenis Transaksi",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,fontFamily: "JakartaSans"),
            ),
            SizedBox(height: 8.0),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              GestureDetector(
                onTap: () => _onContainerTapped(0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
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
                      Text(
                        "Pendapatan",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: jenistransaksiindex==0 ?FontWeight.bold:FontWeight.normal,fontFamily: "JakartaSans",
                          color: jenistransaksiindex == 0
                              ? HexColor("214F3B")
                              : HexColor("6B7280"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              GestureDetector(
                onTap: () => _onContainerTapped(1),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
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
                      Text(
                        "Pengeluaran",
                        style: TextStyle(
                          fontSize: 12,fontFamily: "JakartaSans",
                          fontWeight: jenistransaksiindex==1?FontWeight.bold:FontWeight.normal,
                          color: jenistransaksiindex == 1
                              ? HexColor("214F3B")
                              : HexColor("6B7280"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
            SizedBox(height: 16.0,),
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
                      "Terapkan Filter",
                      style: TextStyle(
                          fontSize: 14.0,fontFamily: "JakartaSans",
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
