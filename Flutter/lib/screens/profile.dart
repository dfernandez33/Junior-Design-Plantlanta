import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:junior_design_plantlanta/model/user.dart';
import 'package:junior_design_plantlanta/screens/add_profile_picture.dart';

enum ProfileTab {
  UPCOMING_EVENTS,
  PAST_EVENTS,
  TRANSACTIONS
}

class Profile extends StatefulWidget {
  UserModel _user;

  Profile(this._user);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileTab _tabSelected = ProfileTab.UPCOMING_EVENTS;
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
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            )),
      );
    } else {
      return Scaffold(
          body: ListView(
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
                                context, MaterialPageRoute(builder: (context) => ProfilePic(this._currentUser)));
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("POST"),
                                  Text("EVENTS"),
                                  Text("DUDES"),
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
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Text("This is a test description!"),
                    ),
                  ],
                ),
              ),
              buildImageViewButtonBar(),
//        buildSelection(),
            ],
          )
      );
    }
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
  Widget _buildProperTab(IconData icon, double size, ProfileTab state) {
    if (state == this._tabSelected) {
      return Expanded(
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0)),
            color: Theme.of(context).primaryColor,
          ),
          child: IconButton(
            icon: Icon(icon, size: size, color: Colors.white),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0)),
          ),
          child: IconButton(
            icon: Icon(icon, size: size),
          ),
        ),
      );
    }
  }

  Future<void> _getImage() async {
    var user = await FirebaseAuth.instance.currentUser();
    setState(() {
      this._imageURL = user.photoUrl;
    });
    this._currentUser = user;
  }

}