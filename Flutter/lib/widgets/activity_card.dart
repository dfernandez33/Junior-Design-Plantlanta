import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_design_plantlanta/model/activity_model.dart';

//TODO: Refactor UI
class ActivityCard extends StatefulWidget {
  ActivityModel _model;
  String userId;

  ActivityCard(this._model) {
    // TODO: Provide a context in global scope
    FirebaseAuth.instance
        .currentUser()
        .then((userId) => this.userId = userId.uid);
  }

  // TODO: Find a controller to update the model in a better way.
  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  bool isExpanded = false;

  _ActivityCardState();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
            onExpansionChanged: (bool expanding) =>
                setState(() => this.isExpanded = expanding),
            backgroundColor: Colors.white,
            title: _buildTitle(),
            children: <Widget>[
              _buildContent(),
            ]),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  widget._model.userName + " " + widget._model.activityType,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: isExpanded
                          ? Theme.of(context).primaryColor
                          : Colors.black54,
                      fontSize: 20.0),
                ))
          ],
        ),
        Row(
          children: <Widget>[
            Column(children: <Widget>[
              Text(
                  _getDate(DateTime.fromMillisecondsSinceEpoch(
                      widget._model.date.seconds * 1000)),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black38, fontSize: 16.0))
            ])
          ],
        ),
      ],
    ));
  }

  Widget _buildContent() {
    return Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(widget._model.description,
                      style: TextStyle(color: Colors.black54, fontSize: 14.0)),
                )),
              ],
            ),
          ],
        ));
  }

  String _getDate(DateTime date) {
    return date.month.toString() +
        "/" +
        date.day.toString() +
        "/" +
        date.year.toString();
  }
}
