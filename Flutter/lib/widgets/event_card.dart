import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:junior_design_plantlanta/serializers/StatusResponse.dart';
import 'package:junior_design_plantlanta/model/event_model.dart';
import 'package:junior_design_plantlanta/widgets/progress_button.dart';

//TODO: Refactor UI
class EventCard extends StatefulWidget {
  EventModel _model;
  String userId;

  bool operator == (o) => o is EventCard && o._model == this._model;

  EventCard(this._model) {
    // TODO: Provide a context in global scope
    FirebaseAuth.instance.currentUser().then((userId) =>
      this.userId = userId.uid);

  }

  // TODO: Find a controller to update the model in a better way.
  @override
  _EventCardState createState() =>
      _EventCardState(_model.participants.contains(userId));
}

class _EventCardState extends State<EventCard> {
  bool isExpanded = false;
  bool isSignUp;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((userId) =>
    setState(() {
      this.isSignUp = widget._model.participants.contains(userId.uid);
    }));
  }

  _EventCardState(this.isSignUp);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(left:12.0, right: 12.0, bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
          backgroundColor: Colors.white,
          title: _buildTitle(),
          children: <Widget>[_buildContent(),]
        ),
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
                child: Text(widget._model.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                        color: isExpanded ?
                          Theme.of(context).primaryColor : Colors.black54,
                        fontSize: 20.0),

               )
              )
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                  children: <Widget>[
                    Text(_getDate(DateTime.fromMillisecondsSinceEpoch(widget._model.date.seconds * 1000)),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16.0)
                  )]
              )
            ],
          ),
        ],
      )
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text("Location: ",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0)),
              ),
              Container(
                child: Text(widget._model.location,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0)),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text("Start Time: ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0)),
              ),
              Container(
                child: Text(widget._model.startTime,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0)),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text("End Time: ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0)),
              ),
              Container(
                child: Text(widget._model.endTime,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0)),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(widget._model.description,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.0)),
              )),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: _buildSignUpButtom(),
          )
        ],
      )
    );
  }

  Widget _buildSignUpButtom() {
    if (isSignUp) {
      return ProgressButton(() => _removeUserFromEvent(),
          Colors.redAccent,
          Colors.grey,
          "Can't make it");
    } else {
      return ProgressButton(() => _signupUser(),
          Theme.of(context).primaryColor,
          Colors.grey,
          "Sign Up");
    }
  }

  String _getDate(DateTime date) {
    return date.month.toString()
        + "/" + date.day.toString()
        + "/" + date.year.toString();
  }

//  String _getTime(DateTime date) {
//    if (date.hour >= 12) {
//      return date.hour.toString() + ":" + (date.minute <= 9 ? "0" + date.minute.toString() : date.minute.toString())  + " PM";
//    } else {
//      return date.hour.toString() + ":" + (date.minute <= 9 ? "0" + date.minute.toString() : date.minute.toString()) + " AM";
//    }
//  }

  void _signupUser() async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'signupForEvent ',
    );
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'EventID': widget._model.eventId,
        },
      );

      // TODO: Create controller to not hard-core update of UI.
      isSignUp = true;
      StatusResponse resp = new StatusResponse.fromJson(result.data);
      print(resp.message);

    } catch (e) {
      print(e.message);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("${e.message}"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _removeUserFromEvent() async {
    // Are we fine by rebuilding the model in the component?
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'removeUserFromEvents',
    );
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'EventID': widget._model.eventId,
        },
      );
      isSignUp = false;
      StatusResponse resp = new StatusResponse.fromJson(result.data);
      print(resp.message);

    } catch (e) {
      print(e.message);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("${e.message}"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}