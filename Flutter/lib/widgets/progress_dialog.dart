import 'package:cloud_functions/cloud_functions.dart';
import 'package:junior_design_plantlanta/serializers/StatusResponse.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ProgressDialog extends StatefulWidget {
  final Function callback;
  final Widget content;
  final String buttonText;
  final String title;

  ProgressDialog(this.callback, this.content, this.buttonText, this.title);

  @override
  State<StatefulWidget> createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  bool isButtonClicked = false;

  @override
  void initState() {
    this.isButtonClicked = false;
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isButtonClicked) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
            child: Center(
                child: CircularProgressIndicator(
          value: null,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )))
      ])));
    } else {
      return _buildInformationView();
    }
  }

  Widget _buildInformationView() {
    return AlertDialog(
      title: new Text(widget.title),
      content: widget.content,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text(
            widget.buttonText,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Color(0xFF25A325)),
          ),
          onPressed: () => _resolveCallback(),
        ),
      ],
    );
  }

  void _resolveCallback() {
    if (widget.callback == null) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        this.isButtonClicked = true;
      });
      widget.callback();
    }
  }
}
