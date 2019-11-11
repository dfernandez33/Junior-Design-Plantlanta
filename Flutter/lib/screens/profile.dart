import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:junior_design_plantlanta/model/user.dart';

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

  @override
  Widget build(BuildContext context) {
    if (widget._user == null) {
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
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage("https://icon-library.net/icon/default-profile-icon-24.html"),
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
                  ],
                ),
              ),
              buildImageViewButtonBar(),
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width,
                    color: Theme.of(context).primaryColor,
                  ),
                  _buildTabContent(),
                ],
              ),
//        buildSelection(),
            ],
          )
      );
    }
  }

  Widget _buildTabContent() {
    if (this._tabSelected == ProfileTab.UPCOMING_EVENTS) {
      return Text("ProfileTab.UPCOMING_EVENTS");
    } else if (this._tabSelected == ProfileTab.PAST_EVENTS) {
      return Text("ProfileTab.PAST_EVENTS");
    } else if (this._tabSelected == ProfileTab.TRANSACTIONS) {
      return Text("ProfileTab.TRANSACTIONS");
    } else {
      print("ERROR UNKNOWN TAB");
    }
  }

  Widget backgroundLayer() {
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).primaryColor,
      );
  }

  Row buildImageViewButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildProperTab(Icons.schedule, 26, ProfileTab.UPCOMING_EVENTS),
        _buildProperTab(Icons.restore, 28, ProfileTab.PAST_EVENTS),
        _buildProperTab(Icons.payment, 28, ProfileTab.TRANSACTIONS),
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
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              icon: Icon(icon, size: size, color: Colors.white),
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
            ),
          ),
        ),
      );
    }
  }
  Widget _getImage() {
    return Image.asset(
      'assets/add_profile_picture.png', fit: BoxFit.fitHeight, color: Colors.grey[400],);
  }
}