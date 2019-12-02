import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:image_cropper/image_cropper.dart';

class ProfilePic extends StatefulWidget {
  FirebaseUser _currentUser;

  ProfilePic(this._currentUser);

  @override
  ProfilePicState createState() => ProfilePicState();
}

class ProfilePicState extends State<ProfilePic> {
  void initState() {
    super.initState();

    setState(() {
      this._currentUser = widget._currentUser;
      this._profilePictureURL = widget._currentUser.photoUrl;
    });
  }

  FirebaseUser _currentUser;
  File _profilePicture;
  String _profilePictureURL;
  String _stateString = "Cancel";
  UserUpdateInfo _info = UserUpdateInfo();

  @override
  Widget build(BuildContext context) {
    if (this._currentUser == null) {
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
        appBar: AppBar(
          centerTitle: true,
          title: Text("Change Your Profile Picture"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    onPressed: _clear,
                  ),
                ],
              ),
            )
          ],
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 48.0),
              Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                      child: CircleAvatar(
                        radius: 150,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: SizedBox(
                            height: 290,
                            width: 290,
                            child: _getImage(),
                          ),
                        ),
                      ),
                      width: 310.0,
                      height: 310.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: new BoxDecoration(
                        color: Color(0xFF25A325), // border color
                        shape: BoxShape.circle,
                      ))),
              const SizedBox(height: 58.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(right: 0.0, left: 0.0, top: 10.0),
                    child: FlatButton(
                      onPressed: selectImageFromCamera,
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(
                          color: Colors.brown[300],
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
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
                        height: 60.0,
                        decoration: new BoxDecoration(
                          color: Colors.brown[300],
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.photo_library,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 48.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 7),
              FlatButton.icon(
                  color: Colors.transparent,
                  label: Text(
                    _stateString,
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF25A325)),
                  ),
                  icon: Icon(Icons.navigate_next, color: Color(0xFF25A325)),
                  onPressed: next),
              SizedBox(width: 7),
            ],
          ),
          color: Color(0xFFFAFAFA),
          shape: CircularNotchedRectangle(),
        ),
      );
    }
  }

  Future<void> selectImageFromCamera() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _profilePicture = image;
      });

      await _cropImage();
    } catch (e) {
      print(e.message);
    }

    if (_profilePicture != null) {
      _stateString = "Continue";
    }
  }

  Future<void> selectImageFromLibrary() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _profilePicture = image;
      });

      await _cropImage();
    } catch (e) {
      print(e.message);
    }

    if (_profilePicture != null) {
      _stateString = "Continue";
    }
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _profilePicture.path,
        cropStyle: CropStyle.circle,
        maxHeight: 290,
        maxWidth: 290);

    setState(() {
      _profilePicture = cropped ?? _profilePicture;
    });
  }

  Future<void> _clear() async {
    setState(() {
      _profilePicture = null;
      _stateString = "Cancel";
    });
  }

  Future<void> uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Profile_Pictures/${Path.basename(_profilePicture.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_profilePicture);

    var snapshot = await uploadTask.onComplete;

    await snapshot.ref.getDownloadURL().then((fileURL) async {
      _profilePictureURL = fileURL;

      await Firestore.instance
          .collection("Users")
          .document(_currentUser.uid)
          .updateData({'picture': fileURL});

      _info.photoUrl = _profilePictureURL;
      await _currentUser.updateProfile(_info);
    });
  }

  Future<void> next() async {
    if (_stateString == "Continue") {
      try {
        await uploadFile();
      } catch (e) {
        print(e.message);
      }
      Navigator.pop(context, _info.photoUrl);
    } else {
      Navigator.pop(context, _currentUser.photoUrl);
    }
  }

  Widget _getImage() {
    if (_profilePictureURL == null) {
      return Image.asset(
        'assets/add_profile_picture.png',
        fit: BoxFit.fitWidth,
        color: Colors.grey[400],
      );
    } else if (_profilePictureURL != null && _profilePicture == null) {
      return Image.network(_profilePictureURL, fit: BoxFit.fitWidth);
    }
    return Image.file(_profilePicture, fit: BoxFit.fitWidth);
  }
}
