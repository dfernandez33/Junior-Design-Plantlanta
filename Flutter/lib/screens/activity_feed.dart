import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/activity_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';
import 'package:junior_design_plantlanta/screens/profile.dart';
import 'package:junior_design_plantlanta/services/user_service.dart';
import 'package:junior_design_plantlanta/widgets/activity_card.dart';
import 'package:algolia/algolia.dart';
import 'package:junior_design_plantlanta/services/algolia_service.dart';

class ActivityFeed extends StatefulWidget {
  ActivityFeed();

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  List<ActivityCard> availableActivities = List();
  List<Widget> searchResults = List();
  List rawActivities = List();
  FocusNode _searchFieldFocus = new FocusNode();
  AlgoliaIndexReference algolia =
      AlgoliaService.algolia.instance.index('Users');
  bool isLoading;
  FirebaseUser _currentUser;
  bool _searchingForFriends = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchFieldFocus.addListener(_onFocusChanged);
    _getCurrentUser().then((_) {
      _buildActivityCards();
    });
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || _currentUser == null) {
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
      if (_searchingForFriends) {
        if (searchResults.isEmpty) {
          content = Center(
            child: Text("No results found"),
          );
        } else {
          content = Center(
            child: ListView(
              children: searchResults,
            ),
          );
        }
      } else {
        if (this.availableActivities.isEmpty) {
          content = Center(
            child: Text("No activities found"),
          );
        } else {
          content = Container(
              margin: EdgeInsets.only(top: 12.0),
              child: ListView(children: availableActivities));
        }
      }
      return Scaffold(
          appBar: new AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 2.0,
            leading: _searchingForFriends
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    })
                : null,
            title: Column(children: [
              TextField(
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    hintText: 'Search friends by name or phone'),
                onChanged: _searchFriends,
                focusNode: _searchFieldFocus,
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

  void _onFocusChanged() {
    setState(() {
      _searchingForFriends = !_searchingForFriends;
      searchResults = List();
    });
  }

  void _searchFriends(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = List();
      });
    } else {
      this.algolia.search(query).getObjects().then((results) {
        var tempResults = results.hits.map((hit) {
          // map each hit to a friend card
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Firestore.instance
                        .collection("Users")
                        .document(hit.objectID)
                        .get()
                        .then((user) {
                      user.data.addEntries([MapEntry("uuid", hit.objectID)]);
                      var userModel = UserModel.fromJson(user.data);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Profile(userModel, UserService())));
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      CircularProfileAvatar(
                        hit.data["picture"],
                        radius: 40,
                        backgroundColor: Colors.white,
                        borderWidth: 3,
                        borderColor: Color(0xFF25A325),
                        elevation: 5.0,
                        showInitialTextAbovePicture: true,
                      ),
                      Container(
                        child: Text(hit.data["name"]),
                        padding: EdgeInsets.only(left: 10.0),
                      )
                    ],
                  ),
                )),
          );
        }).toList();
        setState(() {
          this.searchResults = tempResults;
        });
      });
    }
  }
}
