import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:junior_design_plantlanta/Classes/StatusResponse.dart';
import 'package:junior_design_plantlanta/widgets/progress_button.dart';

//TODO: Refactor UI

class EventCard extends StatefulWidget {
  String _name;
  String _description;
  bool _isRecurrent;
  String _date;
  String _time;
  bool _isUserSignUp;
  String _eventId;

  EventCard(this._name,
      this._time,
      this._description,
      this._date,
      this._isUserSignUp,
      this._eventId);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
          backgroundColor: Colors.white,
          title: _buildTitle(),
          trailing: SizedBox(),
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
                child: Text("Plantlanta Summer Fest",
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
                    Text("6/1/2019",
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
                child: Text("Piedmont Park",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0)),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text("Time: ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0)),
              ),
              Container(
                child: Text("10:00am - 7:00pm",
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
                    child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam risus tellus, euismod a interdum vel, pulvinar vitae leo. Etiam sed luctus ex, ut sodales nunc. Integer at mattis purus. Curabitur vitae nisl ultrices, eleifend metus a, auctor neque. Curabitur enim augue, commodo a turpis in, imperdiet eleifend dui.",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.0)),
              )),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: _buildSignUpButtom(),
          )
        ],
      )
    );
  }

  Widget _buildSignUpButtom() {
    return ProgressButton(() => _signupUser(),
        Theme.of(context).primaryColor,
        Colors.grey,
        "Sign Up",
        "You are Signed Up!");
  }
  void _signupUser() async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'signupForEvent ',
    );
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'EventID': 'rXeFXbwByGMhC1VX6t4c',
        },
      );
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
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'removeUserFromEvents',
    );
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'EventID': 'rXeFXbwByGMhC1VX6t4c',
        },
      );
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