import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:junior_design_plantlanta/screens/login.dart';
import 'package:junior_design_plantlanta/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Plantlanta',
        theme: new ThemeData(
            primaryColor: const Color(0xFF25A325),
            accentColor: const Color(0xFFFFDB2B),
            backgroundColor: const Color(0xFFFAFAFA),
            fontFamily: 'Mukta',
        ),
        home: _handleCurrentScreen()
    );
  }

  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //TODO: Send user to splash page
            return LoginPage();
          } else {
            if (snapshot.hasData) {
              if (snapshot.data.isEmailVerified) {
                return MainScreen();
              } else {
                return VerifyEmail();
              }
            } else {
              return LoginPage();
            }
          }
        }
    );
  }
}