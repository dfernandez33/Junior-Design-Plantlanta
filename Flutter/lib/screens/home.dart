import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:junior_design_plantlanta/widgets/event_card.dart';
import 'package:junior_design_plantlanta/model/event_model.dart';
import 'package:algolia/algolia.dart';
import 'package:junior_design_plantlanta/services/algolia_service.dart';



class Home extends StatefulWidget {
  // TODO: Remove param after final implementation.
  int _number;

  Home(this._number);

  @override
  _HomeState createState() => _HomeState(this._number);
}

class _HomeState extends State<Home> {
  int _number;
  List<EventCard> availableEvents;
  List rawEvents;
  AlgoliaIndexReference algolia = AlgoliaService.algolia.instance.index('Events');
  bool isLoading;

  _HomeState(this._number) {
    availableEvents = List();
    rawEvents = List();
    _buildEventCards();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          value: null,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )),
      );
    } else {
      Widget content;
      if (this.availableEvents.length == 0) {
        content = Center(
          child: Text("No Events Found"),
        );
      } else {
        content = Container(
            margin: EdgeInsets.only(top: 12.0),
            child: ListView(children: availableEvents));
      }
      return Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 2.0,
          title: Column(children: [
            TextField(
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(hintText: 'Search events by name or location'),
              onChanged: (text) {
                 _updateFilteredEvents(text);
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
            child: content,
      );
    }
  }

  void _buildEventCards() {
    this.isLoading = true;
    List<EventCard> events = List();
    getEvents().then((response) {
      if (response != null) {
        response["events"].forEach((event) {
          this.rawEvents.add(event);
          events.add(EventCard(EventModel.fromJson(event)));
        });
        setState(() {
          this.isLoading = false;
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

  void _updateFilteredEvents(String query) {
    this.algolia.search(query).getObjects().then((results) {
      List hitIDs = results.hits.map((hit) => hit.objectID).toList();
      List updatedEvents = this.rawEvents.where((event) => hitIDs.contains(event['eventId'])).toList();
      setState(() {
        this.availableEvents = updatedEvents.map((event) => EventCard(EventModel.fromJson(event))).toList();
      });
    });
  }
}
