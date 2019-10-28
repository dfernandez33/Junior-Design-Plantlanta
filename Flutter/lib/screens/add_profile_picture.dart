import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/registration_model.dart';
import 'package:junior_design_plantlanta/screens/preferences1_screen.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class ProfilePic extends StatefulWidget {
  UserRegistrationModelBuilder _newUser;

  ProfilePic(this._newUser);

  @override
  ProfilePicState createState() => ProfilePicState();
}

class ProfilePicState extends State<ProfilePic> {
  File _profilePicture;

  String _stateString = "Skip for now";

  String _profilePictureURL =
      'https://firebasestorage.googleapis.com/v0/b/junior-design-plantlanta.appspot.com/o/Profile_Pictures%2Fadd_profile_picture.png?alt=media&token=896f21a6-89aa-407c-a106-f8a6824d3407';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Choose a Profile Picture"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProfileAvatar(
                _profilePictureURL,
                radius: 100,
                backgroundColor: Colors.white,
                borderWidth: 10,
                borderColor: Color(0xFF25A325),
                elevation: 5.0,
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(right: 0.0, left: 0.0, top: 10.0),
                    child: FlatButton(
                      onPressed: selectImageFromCamera,
                      child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            color: Color(0xFF25A325),
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            "Camera",
                            style: new TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(right: 0.0, left: 0.0, top: 10.0),
                        child: FlatButton(
                          onPressed: selectImageFromLibrary,
                          child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                color: Color(0xFF25A325),
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "Library",
                                style: new TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 24.0),

              Padding(
                padding: const EdgeInsets.only(
                    right: 0.0, left: 0.0, top: 10.0),
                child: FlatButton(
                  onPressed: next,
                  child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Text(
                        _stateString,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF25A325)),
                      )),
                ),
              )

            ],
          ),
        ));
  }

  Future<void> selectImageFromCamera() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      _profilePicture = image;
      await uploadFile();
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> selectImageFromLibrary() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      _profilePicture = image;
      await uploadFile();
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Profile_Pictures/${Path.basename(_profilePicture.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_profilePicture);

    await uploadTask.onComplete;

    print('File Uploaded');

    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _profilePictureURL = fileURL;
      });
    });

    _stateString = "Continue";
  }

  Future<void> next() async {
    try {
      widget._newUser.profileUrl = _profilePictureURL;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Preferences1(widget._newUser)));
    } catch (e) {
      print(e.message);
    }
  }
}