import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/widgets/progress_button.dart';

class VerifyEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        ProgressButton(
            () {}, Color(0xFF25A325), Colors.grey, "Resend Verification Email")
      ],
    );
  }
}
