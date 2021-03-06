import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:junior_design_plantlanta/model/transaction_model.dart';
import 'package:junior_design_plantlanta/model/event_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';
import 'package:junior_design_plantlanta/services/profile_data_service.dart';
import 'package:junior_design_plantlanta/services/user_service.dart';
import 'package:junior_design_plantlanta/widgets/transaction_card.dart';
import 'package:junior_design_plantlanta/widgets/event_card.dart';
import 'package:junior_design_plantlanta/widgets/past_event_card.dart';
import 'package:junior_design_plantlanta/screens/add_profile_picture.dart';

enum ProfileTab { UPCOMING_EVENTS, PREVIOUS_EVENTS, TRANSACTIONS }

class Profile extends StatefulWidget {
  UserService _userService;
  UserModel _user = UserModel();

  Profile(this._user, this._userService);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileTab _tabSelected = ProfileTab.UPCOMING_EVENTS;
  Map<ProfileTab, bool> isLoading = HashMap();
  ProfileDataService dataService;
  Set<TransactionModel> _transactions = LinkedHashSet();
  Set<EventModel> _currentEvents = LinkedHashSet();
  Set<EventModel> _pastEvents = LinkedHashSet();
  FlatButton _friendRequestButton;

  FirebaseUser _currentUser;

  @override
  void initState() {
    super.initState();
    this.isLoading[ProfileTab.UPCOMING_EVENTS] = true;
    this.isLoading[ProfileTab.PREVIOUS_EVENTS] = true;
    this.isLoading[ProfileTab.TRANSACTIONS] = true;

    _getCurrentUser();

    // TODO: Find a way to mantain updated the user.
    if (widget._user == null) {
      widget._userService.userModelStream.stream
          .asBroadcastStream()
          .listen((user) {
        this.dataService = ProfileDataService(user);
        this.dataService.transactionStream().stream.listen((data) {
          if (data.length != _transactions.length) {
            setState(() {
              this._transactions.addAll(data);
              this.isLoading[ProfileTab.TRANSACTIONS] = false;
            });
          }
        });
        this.dataService.currentEventStream().stream.listen((data) {
          setState(() {
            this._currentEvents.addAll(data);
            this.isLoading[ProfileTab.UPCOMING_EVENTS] = false;
          });
        });
        this.dataService.pastEventStream().stream.listen((data) {
          setState(() {
            this._pastEvents.addAll(data);
            this.isLoading[ProfileTab.PREVIOUS_EVENTS] = false;
          });
        });
      });
    } else {
      this.dataService = ProfileDataService(widget._user);
      this.dataService.transactionStream().stream.listen((data) {
        if (data.length != _transactions.length) {
          setState(() {
            this._transactions.addAll(data);
            this.isLoading[ProfileTab.TRANSACTIONS] = false;
          });
        }
      });
      this.dataService.currentEventStream().stream.listen((data) {
        setState(() {
          this._currentEvents.addAll(data);
          this.isLoading[ProfileTab.UPCOMING_EVENTS] = false;
        });
      });
      this.dataService.pastEventStream().stream.listen((data) {
        setState(() {
          this._pastEvents.addAll(data);
          this.isLoading[ProfileTab.PREVIOUS_EVENTS] = false;
        });
      });
    }
  }

  @override
  void dispose() {
    this.dataService.streamPastEvents.close();
    this.dataService.streamTrans.close();
    this.dataService.streamCurrentEvents.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._user == null || widget._user.picture == null || _currentUser == null) {
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
          body: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircularProfileAvatar(
                        widget._user.picture,
                        radius: 40,
                        backgroundColor: Colors.white,
                        borderWidth: 3,
                        borderColor: Color(0xFF25A325),
                        elevation: 5.0,
                        onTap: _currentUser.uid != widget._user.uuid ? null : () async {
                          String newUrl = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePic(this._currentUser)));
                          setState(() {
                            widget._user.rebuild(((b) => b..picture = newUrl));
                          });
                        },
                        showInitialTextAbovePicture: true,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      widget._user.points.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text("Points"),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      widget._user.confirmedEvents.length
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text("Events"),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      widget._user.friends.length.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text("Friends"),
                                  ],
                                ),
                              ],
                            ),
                            buildFriendRequestButton()
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        widget._user.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            buildImageViewButtonBar(),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).primaryColor,
                ),
                _buildTabContent(),
              ],
            )
          ]));
    }
  }

  Row buildImageViewButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildProperTab(Icons.schedule, 26, ProfileTab.UPCOMING_EVENTS),
        _buildProperTab(Icons.restore, 28, ProfileTab.PREVIOUS_EVENTS),
        _buildProperTab(Icons.timeline, 28, ProfileTab.TRANSACTIONS),
      ],
    );
  }

  Row buildFriendRequestButton() {
    if (_currentUser.uid != widget._user.uuid) {
      if (widget._user.friends.contains(_currentUser.uid)) {
        _friendRequestButton = FlatButton(
            onPressed: null,
            child: Container(
                alignment: Alignment.center,
                height: 30.0,
                decoration: new BoxDecoration(
                  color: Colors.grey,
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Friends",
                      style: new TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    Icon(Icons.check)
                  ],
                )));
      } else {
        if (_friendRequestButton == null) {
          buildFriendRequestButtonContents();
          _friendRequestButton = FlatButton(
              onPressed: null,
              child: Container(
                  alignment: Alignment.center,
                  height: 30.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Loading...",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  )));
        }
      }
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding:
                        const EdgeInsets.only(right: 0.0, left: 0.0, top: 10.0),
                    child: _friendRequestButton)),
          ]);
    } else {
      return Row();
    }
  }

  Future<FlatButton> buildFriendRequestButtonContents() async {
    Map<String, String> friendRequestMap = await getFriendRequestDetails();
    var newFlatButton;
    if (friendRequestMap["sender"] == null) {
      newFlatButton = FlatButton(
        onPressed: createFriendRequest,
        child: Container(
            alignment: Alignment.center,
            height: 30.0,
            decoration: new BoxDecoration(
              color: Color(0xFF25A325),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Text(
              "Send Friend Request",
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            )),
      );
    } else if (friendRequestMap["sender"] == _currentUser.uid) {
      newFlatButton = FlatButton(
        onPressed: () {},
        child: Container(
            alignment: Alignment.center,
            height: 30.0,
            decoration: new BoxDecoration(
              color: Color(0xFF25A325),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Text(
              "Request Pending",
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            )),
      );
    } else {
      newFlatButton = FlatButton(
        onPressed: acceptFriendRequest,
        child: Container(
            alignment: Alignment.center,
            height: 30.0,
            decoration: new BoxDecoration(
              color: Color(0xFF25A325),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Text(
              "Accept Request",
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            )),
      );
    }

    setState(() {
      _friendRequestButton = newFlatButton;
    });
  }

  Future<Map<String, String>> getFriendRequestDetails() {
    return Firestore.instance
        .collection("FriendRequests")
        .where('users', arrayContains: widget._user.uuid)
        .snapshots()
        .first
        .then((friendRequest) {
          var request = friendRequest.documents.where((request) {return request.data["users"].contains(_currentUser.uid);}).toList();
          return {"sender": request.elementAt(0).data["sender"], "receiver": request.elementAt(0).data["receiver"]};
    });
  }

  void createFriendRequest() {
    Firestore.instance.collection('FriendRequests').add({
      "users": [_currentUser.uid, widget._user.uuid],
      "sender": _currentUser.uid,
      "receiver": widget._user.uuid
    }).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Friend Request Sent"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  "close",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color(0xFF25A325)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void acceptFriendRequest() {
    Firestore.instance
        .collection("Users")
        .document(_currentUser.uid)
        .updateData({
      "friends": FieldValue.arrayUnion([widget._user.uuid])
    });

    Firestore.instance
        .collection("Users")
        .document(widget._user.uuid)
        .updateData({
      "friends": FieldValue.arrayUnion([_currentUser.uid])
    });

    Firestore.instance
        .collection("FriendRequests")
        .where('users', arrayContains: widget._user.uuid)
        .snapshots()
        .listen((friendRequest) {
      var request = friendRequest.documents.where((request) {return request.data["users"].contains(_currentUser.uid);}).toList();
      request.elementAt(0).reference.delete();

    });
  }

  void _tabSelector(ProfileTab newState) {
    setState(() {
      this._tabSelected = newState;
    });
  }

  Widget _buildProperTab(IconData icon, double size, ProfileTab state) {
    if (state == this._tabSelected) {
      return Expanded(
        child: GestureDetector(
          child: Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0)),
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              icon: Icon(icon, size: size, color: Colors.white),
              onPressed: () => _tabSelector(state),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: GestureDetector(
          onTap: () => _tabSelector(state),
          child: Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0)),
            ),
            child: IconButton(
              icon: Icon(icon, size: size),
              onPressed: () => _tabSelector(state),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildTabContent() {
    switch (this._tabSelected) {
      case ProfileTab.UPCOMING_EVENTS:
        {
          if (isLoading[ProfileTab.UPCOMING_EVENTS]) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.40,
              child: Center(
                  child: CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )),
            );
          } else if (this._currentEvents.isEmpty) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.40,
              child: Center(
                  child: Text(
                "NO EVENTS FOUND",
                style: TextStyle(color: Colors.white),
              )),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 12.0),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 30.0),
                children: this
                    ._currentEvents
                    .map((model) => EventCard(model))
                    .toList(),
                scrollDirection: Axis.vertical,
              ),
            );
          }
        }
        break;
      case ProfileTab.PREVIOUS_EVENTS:
        {
          if (isLoading[ProfileTab.PREVIOUS_EVENTS]) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.40,
              child: Center(
                  child: CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )),
            );
          } else if (this._pastEvents.isEmpty) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.40,
              child: Center(
                  child: Text(
                "NO EVENTS FOUND",
                style: TextStyle(color: Colors.white),
              )),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 12.0),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 30.0),
                children: this
                    ._pastEvents
                    .map((model) => PastEventCard(model))
                    .toList(),
                scrollDirection: Axis.vertical,
              ),
            );
          }
        }
        break;
      case ProfileTab.TRANSACTIONS:
        {
          if (isLoading[ProfileTab.TRANSACTIONS]) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.40,
              child: Center(
                  child: CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )),
            );
          } else if (this._transactions.isEmpty) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.40,
              child: Center(
                  child: Text(
                "NO TRANSACTIONS FOUND",
                style: TextStyle(color: Colors.white),
              )),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 12.0),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 30.0),
                children: this
                    ._transactions
                    .map((model) => TransactionCard(model))
                    .toList(),
                scrollDirection: Axis.vertical,
              ),
            );
          }
        }
        break;
    }
  }

  Future<void> _getCurrentUser() async {
    var user = await FirebaseAuth.instance.currentUser();
    this._currentUser = user;
  }
}
