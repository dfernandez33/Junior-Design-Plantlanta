import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_design_plantlanta/model/activity_model.dart';
import 'package:junior_design_plantlanta/model/user.dart';

//TODO: Refactor UI
class ActivityCard extends StatefulWidget {
  ActivityModel _model;
  String userId;

  ActivityCard(this._model) {
    // TODO: Provide a context in global scope
    FirebaseAuth.instance
        .currentUser()
        .then((userId) => this.userId = userId.uid);
  }

  // TODO: Find a controller to update the model in a better way.
  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  String imgUrl;
  _ActivityCardState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance.collection("Users")
        .document(widget._model.uuid)
        .get().then((data) {
          setState(() {
            this.imgUrl = data.data["picture"];
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row (
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[getPhoto(), _buildTitle()],
        ),
    ));
  }

  Widget getPhoto() {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: CircularProfileAvatar(this.imgUrl ?? "",
        radius: 20,
        backgroundColor: Colors.white,
        borderWidth: 3,
        borderColor: Color(0xFF25A325),
        elevation: 5.0,
        onTap: () {},
        showInitialTextAbovePicture: true,
      )
    );
  }

  Widget _buildTitle() {
    return Flexible(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  widget._model.userName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20.0),
                ))
          ],
        ),
        Row(
          children: <Widget>[
            Column(children: <Widget>[
              Text(
                  _getDate(DateTime.fromMillisecondsSinceEpoch(
                      widget._model.date.seconds * 1000)),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black38, fontSize: 16.0))
            ])
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(widget._model.description,
                      style: TextStyle(color: Colors.black54, fontSize: 14.0)),
                )),
          ],
        ),
      ],
    ));
  }

  String _getDate(DateTime date) {
    return date.month.toString() +
        "/" +
        date.day.toString() +
        "/" +
        date.year.toString();
  }
}
