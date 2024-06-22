import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sukauang/Main/addtransaction.dart';
import 'package:sukauang/Main/historytransaction.dart';
import 'package:sukauang/Main/home.dart';
import 'package:sukauang/Main/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

class bottomnavbar extends StatefulWidget {
  @override
  _bottomnavbarState createState() => _bottomnavbarState();
}

class _bottomnavbarState extends State<bottomnavbar> {

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


  List<Widget> _current = [
    home(),
    historytransaction(),
    addTransaction(),
    profile(),
  ];
  
  void _onItemTapped(int index) {
    if (index == 4) {
      showFloatingText(context,"Fitur ini masih dalam pengembangan, nantikan pembaharuan dari kami");
      return;
    }
    _selectedIndexNotifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder<int>(valueListenable: _selectedIndexNotifier,
                  builder: (context, selectedIndex, _) {
            return _current[selectedIndex];
          },),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(valueListenable: _selectedIndexNotifier, builder: (context, selectedIndex, _) {return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: selectedIndex == 0
                ? SvgPicture.asset(
                    "images/home(select).svg",
                    width: 24.0,
                  )
                : SvgPicture.asset(
                    "images/home.svg",
                    height: 24,
                  ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 1
                ? SvgPicture.asset(
                    "images/transaction(select).svg",
                    width: 24.0,
                  )
                : SvgPicture.asset(
                    "images/transaction.svg",
                    width: 24.0,
                  ),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "images/add.svg",
              width: 48,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 3
                ? SvgPicture.asset(
                    "images/profile(select).svg",
                    width: 24.0,
                  )
                : SvgPicture.asset(
                    "images/profile.svg",
                    width: 24.0,
                  ),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "images/setting.svg",
              width: 24.0,
            ),
            label: 'Setting',
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "JakartaSans",
          fontSize: 10,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
          fontFamily: "JakartaSans",
        ),
        selectedItemColor: HexColor("214F3B"),
        unselectedItemColor: HexColor("214F3B"),
        currentIndex: selectedIndex,
      );})
      
    );
  }
}

void changeIndex(int newIndex) {
  _selectedIndexNotifier.value = newIndex;
}