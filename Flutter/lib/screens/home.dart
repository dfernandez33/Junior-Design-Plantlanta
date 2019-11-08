import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:junior_design_plantlanta/widgets/event_card.dart';
import 'package:junior_design_plantlanta/model/event_model.dart';

class Home extends StatefulWidget {
  // TODO: Remove param after final implementation.
  int _number;
  String queryText;

  Home(this._number);

  @override
  _HomeState createState() => _HomeState(this._number);
}

class _HomeState extends State<Home> {
  int _number;
  List<EventCard> availableEvents;

  _HomeState(this._number) {
    availableEvents = List();
    _buildEventCards();
  }

  @override
  Widget build(BuildContext context) {
    if (availableEvents.length == 0) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          value: null,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )),
      );
    } else {
      return Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 2.0,
          title: Column(children: [
            TextField(
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(hintText: 'Enter a search term'),
              onChanged: (text) {
                widget.queryText = text;
              },
            ),
          ]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 12.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(children: availableEvents)),
      );
    }
  }

  void _buildEventCards() {
    List<EventCard> events = List();
    getEvents().then((response) {
      if (response != null) {
        response["events"].forEach(
            (event) => events.add(EventCard(EventModel.fromJson(event))));
        setState(() {
          this.availableEvents = events;
        });
      }
    });
  }

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
