import 'package:conocithon_geeks/configs/login.dart';
import 'package:conocithon_geeks/configs/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/app_themes/themes.dart';
import 'configs/google_login_package/google_signin.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          title: 'PocketDoc',
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              return NavBarWidget();
            } else {
              return SignInPage();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );
}
