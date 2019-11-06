import 'package:cloud_functions/cloud_functions.dart';
import 'package:junior_design_plantlanta/serializers/StatusResponse.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ProgressDialog extends StatefulWidget {
  final Function callback;
  final Widget content;
  final String buttonText;
  final String title;
  final bool isMarketplace;

  ProgressDialog(this.callback, this.content, this.buttonText, this.title, this.isMarketplace);

  @override
  State<StatefulWidget> createState() => _ProgressDialogState();
}

enum DialogState {
  WAITING_FOR_RESPONSE,
  ERROR_ON_RESPONSE,
  SUCCESS_ON_RESPONSE,
  DISPLAY_CONTENT,
}

class _ProgressDialogState extends State<ProgressDialog> {
  DialogState dialogState;

  @override
  void initState() {
    this.dialogState = DialogState.DISPLAY_CONTENT;
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (dialogState == DialogState.WAITING_FOR_RESPONSE) {
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
    } else if (dialogState == DialogState.SUCCESS_ON_RESPONSE) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    child: Center(
                        child: Text("SUCESS")))
              ])));
    } else if (dialogState == DialogState.ERROR_ON_RESPONSE) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    child: Center(
                        child: Text("ERROR")))
              ])));
    } else {
      return _buildInformationView();
    }
  }

  Widget _buildInformationView() {
    Widget button = FlatButton(
        child: new Text(
          widget.buttonText,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Color(0xFF25A325)),
        ),
        onPressed: () => _resolveCallback(),
      );

    return AlertDialog(
      title: new Text(widget.title),
      content: widget.content,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
          button,
      ],
    );
  }

  void _resolveCallback() {
    if (widget.callback == null) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        this.dialogState = DialogState.WAITING_FOR_RESPONSE;
      });
      Future<int> status = widget.callback();
      status.asStream().listen(
          (status) {
            if (status == 1) {
              setState(() {
                this.dialogState = DialogState.SUCCESS_ON_RESPONSE;
              });
            } else if (status == 0) {
              setState(() {
                this.dialogState = DialogState.ERROR_ON_RESPONSE;
              });
            }
          }
      );
    }
  }
}
