import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sukauang/Main/addtransaction.dart';
import 'package:sukauang/Main/historytransaction.dart';
import 'package:sukauang/Main/home.dart';
import 'package:sukauang/Main/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class bottomnavbar extends StatefulWidget {
  @override
  _bottomnavbarState createState() => _bottomnavbarState();
}

class _bottomnavbarState extends State<bottomnavbar> {
  int _selectedIndex = (0);

  List<Widget> _current = [
    home(),
    historytransaction(),
    addtransaction(),
    profile(),
  ];
  
  void _onItemTapped(int index) {
    if (index == 4) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _current[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
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
            icon: _selectedIndex == 1
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
            icon: _selectedIndex == 3
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
        currentIndex: _selectedIndex,
      ),
    );
  }
}
