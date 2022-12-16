import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blood_bank_search.dart';

class OxygenBankDatsets extends StatefulWidget {
  @override
  _OxygenBankDatsetsState createState() => _OxygenBankDatsetsState();
}

class _OxygenBankDatsetsState extends State<OxygenBankDatsets> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.green.shade900,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Text(
            'Search Oxygen Banks',
            style: GoogleFonts.montserrat(
              color: Theme.of(context).primaryColor,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
              onPressed: () {
                showSearch(context: context, delegate: OxygenBankSearch());
              },
            ),
          ],
        ),
        body: Container(
          height: size.height,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
