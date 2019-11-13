import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:junior_design_plantlanta/model/transaction_model.dart';
import 'package:junior_design_plantlanta/model/event_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';
import 'package:junior_design_plantlanta/serializers/date_time_serializer.dart';
import 'package:junior_design_plantlanta/widgets/transaction_card.dart';
import 'package:junior_design_plantlanta/widgets/event_card.dart';
import 'package:junior_design_plantlanta/widgets/past_event_card.dart';
import 'package:junior_design_plantlanta/screens/add_profile_picture.dart';

enum ProfileTab { UPCOMING_EVENTS, PAST_EVENTS, TRANSACTIONS }

class Profile extends StatefulWidget {
  UserModel _user;

  Profile(this._user);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileTab _tabSelected = ProfileTab.UPCOMING_EVENTS;
  List<EventCard> _currentEvents = List();
  List<EventCard> _pastEvents = List();
  List<TransactionCard> transactions = List();


  String _imageURL;
  FirebaseUser _currentUser;

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._user == null || _imageURL == null) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
              value: null,
              valueColor:
              AlwaysStoppedAnimation<Color>(Theme
                  .of(context)
                  .primaryColor),
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
                          CircularProfileAvatar(_imageURL,
                            radius: 40,
                            backgroundColor: Colors.green,
                            borderWidth: 3,
                            borderColor: Color(0xFF25A325),
                            elevation: 5.0,
                            onTap: () async {
                              String newUrl = await Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePic(this._currentUser)));
                              setState(() {
                                this._imageURL = newUrl;
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
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
                                          "10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        Text("Friends"),
                                      ],
                                    ),
                                  ],
                                ),
//                        Row(
//                            mainAxisAlignment:
//                            MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              buildProfileFollowButton(user)
//                            ]),
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    _buildTabContent(),
                  ],
                )
              ]));
    }
  }

  Widget _buildTabContent() {
    if (this._tabSelected == ProfileTab.UPCOMING_EVENTS) {
      if (this._currentEvents.isEmpty) {
        _buildCurrentEventCards();
        return Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 2.40,
          child: Center(
              child: CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )),
        );
      } else {
        return Container(
            margin: EdgeInsets.only(top: 12.0),
            child: ListView(shrinkWrap: true, children: this._currentEvents));
      }
    } else if (this._tabSelected == ProfileTab.PAST_EVENTS) {
      if (this._pastEvents.isEmpty) {
        _buildPastEventCards();
        return Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 2.40,
          child: Center(
              child: CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )),
        );
      } else {
        Container(
            margin: EdgeInsets.only(top: 12.0),
            child: ListView(
              shrinkWrap: true,
              children: this._pastEvents,
            ));
      }
    } else if (this._tabSelected == ProfileTab.TRANSACTIONS) {
      if (this.transactions.isEmpty) {
        _createTransactionCards();
        return Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 2.40,
          child: Center(
              child: CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: 12.0),
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: ListView(
            children: this.transactions,
            scrollDirection: Axis.vertical,
          ),
        );
      }
    } else {
      print("ERROR UNKNOWN TAB");
    }
  }

  Widget backgroundLayer() {
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme
          .of(context)
          .primaryColor,
    );
  }

  Row buildImageViewButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildProperTab(Icons.schedule, 26, ProfileTab.UPCOMING_EVENTS),
        _buildProperTab(Icons.restore, 28, ProfileTab.PAST_EVENTS),
        _buildProperTab(Icons.timeline, 28, ProfileTab.TRANSACTIONS),
      ],
    );
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
          onTap: () => _tabSelector(state),
          child: Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0)),
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            child: IconButton(
              icon: Icon(icon, size: size, color: Colors.white),
              onPressed: () {},
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
              onPressed: () {},
            ),
          ),
        ),
      );
    }
  }

  Future<void> _buildPastEventCards() async {
//    widget._user.events.forEach((event) async {
//      var eventInfo =
//      await Firestore.instance.collection("Events").document(event).get();
//      Timestamp timestamp = eventInfo.data['date'];
//      var tempTime = <String, dynamic>{
//        "_nanoseconds": timestamp.nanoseconds,
//        "_seconds": timestamp.seconds
//      };
//      eventInfo.data['date'] = tempTime;
//      setState(() {
//        _pastEvents.add(EventCard(EventModel.fromJson(eventInfo.data)));
//      });
//    });
  }

  Future<void> _getImage() async {
    var user = await FirebaseAuth.instance.currentUser();
    setState(() {
      this._imageURL = user.photoUrl;
    });
    this._currentUser = user;
  }

  Future<void> _createTransactionCards() {
    Firestore.instance
        .collection("Transactions")
        .where("uuid", isEqualTo: widget._user.uuid)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .listen((transactions) {
      transactions.documents.forEach((transaction) {
        Timestamp timestamp = transaction.data["timestamp"];
        var tempTime = <String, dynamic>{
          "_nanoseconds": timestamp.nanoseconds,
          "_seconds": timestamp.seconds
        };
        transaction.data["timestamp"] = tempTime;
        this
            .transactions
            .add(TransactionCard(TransactionModel.fromJson(transaction.data)));
      });
      setState(() {});
    });
  }

  Future<void> _buildCurrentEventCards() async {
    widget._user.events.forEach((event) async {
      var eventInfo =
      await Firestore.instance.collection("Events").document(event).get();
      Timestamp timestamp = eventInfo.data['date'];
      var tempTime = <String, dynamic>{
        "_nanoseconds": timestamp.nanoseconds,
        "_seconds": timestamp.seconds
      };
      eventInfo.data['date'] = tempTime;
      setState(() {
        _currentEvents.add(EventCard(EventModel.fromJson(eventInfo.data)));
      });
    });
  }
}


