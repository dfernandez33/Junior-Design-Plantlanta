import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/registration_model.dart';
import 'package:junior_design_plantlanta/screens/preferences1_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:image_cropper/image_cropper.dart';

class ProfilePic extends StatefulWidget {
  UserRegistrationModelBuilder _newUser;

  ProfilePic(this._newUser);

  @override
  ProfilePicState createState() => ProfilePicState();
}

class ProfilePicState extends State<ProfilePic> {
  File _profilePicture;

  String _profilePictureURL;

  String _stateString = "Skip for now";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Choose a Profile Picture"),
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
      _stateString = "Skip for now";
    });
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
  }

  Future<void> next() async {
    if (_stateString == "Skip for now") {
      try {
        widget._newUser.profileUrl = _profilePictureURL;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Preferences1(widget._newUser)));
      } catch (e) {
        print(e.message);
      }
    } else {
      try {
        uploadFile();
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

  Widget _getImage() {
    if (_profilePicture == null) {
      return Image.asset('assets/add_profile_picture.png', fit: BoxFit.fill);
    }
    return Image.file(_profilePicture, fit: BoxFit.fill);
  }

}
