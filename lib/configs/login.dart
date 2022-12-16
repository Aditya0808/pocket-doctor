import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'google_login_package/google_signin.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                CircleAvatar(
                  child: Image.asset(
                    'assets/web_hi_res_512.png',
                    fit: BoxFit.fill,
                  ),
                  radius: 160,
                ),
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Text(
                      'Sign In With',
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 26),
                    ),
                  ),
                ),
                Center(child: GoogleSignInButtonWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Color(0xFF57cab0);
    return Container(
      height: 80,
      width: 200,
      //color: Colors.redAccent,
      padding: EdgeInsets.all(4),
      child: OutlinedButton.icon(
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.login();
        },
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
        label: Text(' Google ',
            style: GoogleFonts.montserrat(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
            )),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.green.shade900),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
