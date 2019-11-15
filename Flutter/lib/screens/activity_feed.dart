import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/activity_model.dart';
import 'package:junior_design_plantlanta/widgets/activity_card.dart';
import 'package:algolia/algolia.dart';
import 'package:junior_design_plantlanta/services/algolia_service.dart';


class ActivityFeed extends StatefulWidget {
  // TODO: Remove param after final implementation.

  ActivityFeed();

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  List<ActivityCard> availableActivities = List();
  List rawActivities = List();
  AlgoliaIndexReference algolia = AlgoliaService.algolia.instance.index('Events');
  bool isLoading;
  FirebaseUser _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUser();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || _currentUser == null) {
      _buildActivityCards();
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
      if (this.availableActivities.length == 0) {
        content = Center(
          child: Text("No Activities Found"),
        );
      } else {
        content = Container(
            margin: EdgeInsets.only(top: 12.0),
            child: ListView(children: availableActivities));
      }
      return Scaffold(
          appBar: new AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 2.0,
            title: Column(children: [
              TextField(
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(hintText: 'Search for friends by name'),
                onChanged: (text) {
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
          ));
    }
  }

  Future<void> _getCurrentUser() async {
    var user = await FirebaseAuth.instance.currentUser();
    this._currentUser = user;
  }

  void _buildActivityCards() {
    List<ActivityCard> activityList = List();
    Firestore.instance
        .collection("Activities")
        .where("uuid", isEqualTo: _currentUser.uid)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .listen((activities) {
      activities.documents.forEach((activity) {
        Timestamp timestamp = activity.data["timestamp"];
        var tempTime = <String, dynamic>{
          "_nanoseconds": timestamp.nanoseconds,
          "_seconds": timestamp.seconds
        };
        activity.data["timestamp"] = tempTime;
        activityList.add(ActivityCard(ActivityModel.fromJson(activity.data)));
      });
      setState(() {
        this.availableActivities = activityList;
        this.isLoading = false;
      });
    });
  }
}