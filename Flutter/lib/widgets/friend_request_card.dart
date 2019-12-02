import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_design_plantlanta/model/friend_request_model.dart';

//TODO: Refactor UI
class FriendRequestCard extends StatefulWidget {
  FriendRequestModel _model;

  bool loading = true;

  FriendRequestCard(this._model);

  // TODO: Find a controller to update the model in a better way.
  @override
  _FriendRequestCardState createState() => _FriendRequestCardState();
}

class _FriendRequestCardState extends State<FriendRequestCard> {

  String userId;

  bool loading = true;
  String senderName;
  String senderImageURL;

  _FriendRequestCardState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .currentUser()
        .then((userId) => this.userId = userId.uid);
    _getRequestData().then((void none) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: Center(
            child: CircularProgressIndicator(
              value: null,
              valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            )),
      );
    } else {
      return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircularProfileAvatar(
                  senderImageURL,
                  radius: 40,
                  backgroundColor: Colors.white,
                  borderWidth: 3,
                  borderColor: Color(0xFF25A325),
                  elevation: 5.0,
                  showInitialTextAbovePicture: true,
                ),
                Text(
                    senderName
                ),
                FlatButton(
                  onPressed: acceptRequest(),
                  child: Text("Accept"),
                  color: Color(0xFF25A325),
                ),
                FlatButton(
                  onPressed: denyRequest(),
                  child: Text("Deny"),
                  color: Colors.grey,
                )
              ],
            )
        ),
      );
    }
  }

  Future<void> _getRequestData() {
    return Firestore.instance.collection("Users").document(widget._model.sender).get().then((user) {
      var userData = user.data;
      senderName = userData["name"];
      senderImageURL = userData["picture"];
    });
  }

  acceptRequest() {
    Firestore.instance
        .collection("Users")
        .document(widget._model.sender)
        .updateData({
      "friends": FieldValue.arrayUnion([widget._model.receiver])
    });

    Firestore.instance
        .collection("Users")
        .document(widget._model.receiver)
        .updateData({
      "friends": FieldValue.arrayUnion([widget._model.sender])
    });

    Firestore.instance
        .collection("FriendRequests")
        .where('users', arrayContains: widget._model.sender)
        .snapshots()
        .listen((friendRequest) {
      var request = friendRequest.documents.where((request) {return request.data["users"].contains(widget._model.receiver);}).toList();
      request.elementAt(0).reference.delete();
    });
  }

  denyRequest() {
    Firestore.instance
        .collection("FriendRequests")
        .where('users', arrayContains: widget._model.sender)
        .snapshots()
        .listen((friendRequest) {
      var request = friendRequest.documents.where((request) {return request.data["users"].contains(widget._model.receiver);}).toList();
      request.elementAt(0).reference.delete();
    });
  }
}
