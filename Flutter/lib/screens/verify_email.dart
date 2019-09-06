import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/widgets/progress_button.dart';

class VerifyEmail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildCenteredVerification()
    );
  }

  Widget _buildCenteredVerification() {
    return Row(
      children: <Widget>[
        Text(
          "Please verify your email!",
          textAlign: TextAlign.center,
        ),
    ProgressButton(() {},
        Color(0xFF25A325),
        Colors.grey,
        "Resend Verification Email")
      ],
    );
  }
}