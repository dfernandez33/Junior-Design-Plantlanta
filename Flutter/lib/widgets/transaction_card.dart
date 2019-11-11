import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_design_plantlanta/model/transaction_model.dart';

import 'package:junior_design_plantlanta/serializers/StatusResponse.dart';
import 'package:junior_design_plantlanta/model/event_model.dart';
import 'package:junior_design_plantlanta/widgets/progress_button.dart';

//TODO: Refactor UI
class TransactionCard extends StatefulWidget {
  TransactionModel _model;
  String userId;

  TransactionCard(this._model) {
    FirebaseAuth.instance.currentUser().then((userId) =>
    this.userId = userId.uid);
  }

  // TODO: Find a controller to update the model in a better way.
  @override
  _TransactionCardState createState() =>
      _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  _TransactionCardState();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(left:12.0, right: 12.0, bottom: 12.0, top: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column (
          children: <Widget>[_buildTitle(), _buildContent()],
        )
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(bottom: 5.0),
        child: Text(_getDate(DateTime.fromMillisecondsSinceEpoch(widget._model.date.seconds * 1000)),
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 20.0),
        )
    );
  }

  Widget _buildContent() {

    bool isNegative = widget._model.amount < 0;
    String displayValue = "";
    if (isNegative) {
      displayValue = widget._model.amount.toString();
    } else {
      displayValue = "+" + widget._model.amount.toString();
    }
    return Container(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column (
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child:  Text(displayValue,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: isNegative ? Colors.red : Theme.of(context).primaryColor,
                    fontSize: 15.0
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child:  Text(widget._model.description),
              ),

          ],
        )
    );
  }

  String _getDate(DateTime date) {
    return date.month.toString()
        + "/" + date.day.toString()
        + "/" + date.year.toString();
  }
}