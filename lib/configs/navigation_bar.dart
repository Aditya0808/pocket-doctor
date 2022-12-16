import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:conocithon_geeks/bill_upload/opening_page.dart';
import 'package:conocithon_geeks/chatbot/start.dart';
import 'package:conocithon_geeks/prescription/board.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class NavBarWidget extends StatefulWidget {
  @override
  _NavBarWidgetState createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int _currentIndex = 0;
  final tabs = [FirstPage(), OpeningPage(), BoardApp(), MyChat()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: GoogleFonts.montserrat(
                fontSize: 15,
              ),
            ),
            activeColor: Color(0xFF0492c2),
            inactiveColor: Theme.of(context).secondaryHeaderColor,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.upload_file),
            title: Text(
              'Uploads',
              style: GoogleFonts.montserrat(
                fontSize: 15,
              ),
            ),
            activeColor: Color(0xFF0492c2),
            inactiveColor: Theme.of(context).secondaryHeaderColor,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.note_add),
            title: Text(
              'Records',
              style: GoogleFonts.montserrat(
                fontSize: 15,
              ),
            ),
            activeColor: Color(0xFF0492c2),
            inactiveColor: Theme.of(context).secondaryHeaderColor,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bolt),
            title: Text(
              'HelpBot',
              style: GoogleFonts.montserrat(
                fontSize: 15,
              ),
            ),
            activeColor: Color(0xFF0492c2),
            inactiveColor: Theme.of(context).secondaryHeaderColor,
          ),
        ],
        animationDuration: Duration(milliseconds: 300),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
