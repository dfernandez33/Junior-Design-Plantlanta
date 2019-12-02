import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/friend_request_model.dart';
import 'package:junior_design_plantlanta/widgets/friend_request_card.dart';

class FriendRequests extends StatefulWidget {

  FriendRequests();

  @override
  _FriendRequestsState createState() => _FriendRequestsState();
}

class _FriendRequestsState extends State<FriendRequests> {
  List<FriendRequestCard> friendRequests = List();
  bool isLoading = true;
  FirebaseUser _currentUser;
  
  _FriendRequestsState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      _currentUser = user;
      _getFriendRequests().then((void none) {
        setState(() {
          isLoading = false;
        });
      });
    });
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
      if (this.friendRequests.length == 0) {
        content = Center(
          child: Text("No requests pending"),
        );
      } else {
        content = Container(
            margin: EdgeInsets.only(top: 12.0),
            child: ListView(children: friendRequests));
      }
      return Scaffold(
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
  
  Future<void> _getFriendRequests() {
    return Firestore.instance.collection("FriendRequests").where("receiver", isEqualTo: _currentUser.uid).getDocuments().then((documents) {
      friendRequests = documents.documents.map((request) {
        return FriendRequestCard(FriendRequestModel.fromJson(request.data));
      }).toList();
    });
  }
}
