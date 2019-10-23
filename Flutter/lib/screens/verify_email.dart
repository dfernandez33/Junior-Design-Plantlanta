import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:junior_design_plantlanta/widgets/progress_button.dart';

class VerifyEmail extends StatelessWidget {
  Timer _timer;
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Plantlanta"),
        ),
        body: PageView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Center(
                child: _buildCenteredVerification(),
              )
            ]));
  }

  Widget _buildCenteredVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Please verify your email!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24.0),
        const SizedBox(height: 24.0),

        ProgressButton(_sendVerificationEmail, Color(0xFF25A325), Colors.grey,
            "Send Verification Email")
      ],
    );
  }

  Future<void> _sendVerificationEmail() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.sendEmailVerification().whenComplete(() {
      _timer = Timer.periodic(Duration(seconds: 3), (Timer t) async {
        await user.reload();
        user = await FirebaseAuth.instance.currentUser();
        if (user.isEmailVerified) {
          Navigator.of(_context).pushNamedAndRemoveUntil(
              "/main_screen", (r) => false);
          _timer.cancel();
        }
      });
    });
  }
}
