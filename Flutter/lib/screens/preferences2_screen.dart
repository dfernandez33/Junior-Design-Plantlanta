import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/registration_model.dart';
import 'package:junior_design_plantlanta/model/user_preference.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_design_plantlanta/screens/verify_email.dart';

class Preferences2 extends StatefulWidget {
  UserRegistrationModelBuilder _newUser;
  UserPreferenceModelBuilder _userPreferences;

  Preferences2(this._newUser, this._userPreferences);
  @override
  _Preferences2State createState() => _Preferences2State();
}

class _Preferences2State extends State<Preferences2> {
  int _radioValue1 = -1;
  int _radioValue2 = -1;
  UserUpdateInfo _info = UserUpdateInfo();

  void _handleRadioValueChange1(int value) {
    setState(() {
      widget._userPreferences..sporadic = value == 1;
      _radioValue1 = value; } );
  }

  void _handleRadioValueChange2(int value) {
    String proximity;

    if (value == 1) {
      proximity = "City";
    } else if (value == 2) {
      proximity = "County";
    } else {
      proximity = "State";
    }
    widget._userPreferences..proximity = proximity;

    setState(() {
      _radioValue2 = value; } );
  }

  Map<String, bool> location = {
    'Your city': false,
    'Your county': false,
    'Your state' : false,
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Tell us about you!")
      ),
      body: new Container(
        padding: EdgeInsets.all(8.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 40, right: 10),
                  child: Text(
                    "Do you want to volunteer:",
                    style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(10),
                  ),
                  new Divider(height: 5, color: Colors.black),
                  new Padding(
                  padding: new EdgeInsets.all(10),
                  ),
                  new Text('Sporadically', style: new TextStyle(fontSize: 16)),
                  new Radio(
                    value: 1,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  new Text('Recurringly', style: new TextStyle(fontSize: 16)),
                  new Radio(
                  value: 2,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                  ),
                ],
              ),
            ),
            new Row(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 40, right: 10),
                  child: Text(
                    "Do you want to volunteer anywhere in:",
                    style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new Padding(
                      padding: new EdgeInsets.all(10),
                  ),
                  new Divider(height: 5, color: Colors.black),
                  new Padding(
                      padding: new EdgeInsets.all(10),
                  ),
                  new Text('Your city', style: new TextStyle(fontSize: 16)),
                  new Radio(
                    value: 1,
                    groupValue: _radioValue2,
                    onChanged: _handleRadioValueChange2,
                  ),
                  new Text('Your county', style: new TextStyle(fontSize: 16)),
                  new Radio(
                    value: 2,
                    groupValue: _radioValue2,
                    onChanged: _handleRadioValueChange2,
                  ),
                  new Text('Your state', style: new TextStyle(fontSize: 16)),
                  new Radio(
                    value: 3,
                    groupValue: _radioValue2,
                    onChanged: _handleRadioValueChange2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.arrow_forward,
          color: Theme.of(context).backgroundColor,
        ),
        onPressed: () { verify_email(); },
      ),
    );
  }

  Future<void> verify_email() async {
    widget._newUser.preference = widget._userPreferences;
    final user = widget._newUser.build();
    try {

      var fireBaseUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      _info.photoUrl = widget._newUser.profileUrl;

      await fireBaseUser.updateProfile(_info);

      final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'registerUser',
      );
      final HttpsCallableResult result =
      await callable.call(<String, dynamic> {
        "name" : user.name,
        "dob" : user.dob,
        "phone" : user.phone,
        "address" : user.address,
        "picture" : user.profileUrl,
        "preferences" : {
          "event_type" : user.preference.eventType.toList(),
          "sporadic" : user.preference.sporadic,
          "proximity" : user.preference.proximity
        }
      }
      );
    } catch (e) {
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
    try {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VerifyEmail()));
    } catch (e) {
      print(e.message);
    }
  }
}