import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:junior_design_plantlanta/Classes/StatusResponse.dart';
import 'package:junior_design_plantlanta/widgets/event_card.dart';

class Home extends StatefulWidget {
  // TODO: Remove param after final implementation.
  int _number;

  Home(this._number);

  @override
  _HomeState createState() => _HomeState(this._number);
}

class _HomeState extends State<Home> {
  int _number;


  _HomeState(this._number);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: _buildEventCards()
        )
      ),
    );
  }

  List<EventCard> _buildEventCards() {
    getEvents().then((result) => print(result));
    return [];
  }


  // TODO: Serialize data in PODO
  Future<dynamic> getEvents() async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getAllEvents',
    );
    try {
      final HttpsCallableResult result = await callable.call();
      return Future.value(result.data);
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