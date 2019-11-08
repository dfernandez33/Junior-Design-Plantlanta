import 'package:flutter/material.dart';
import 'package:junior_design_plantlanta/model/user.dart';

class Profile extends StatefulWidget {
  UserModel _user;

  Profile(this._user);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
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
                      "Kike Pastrana 2.0",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text("I am kike!"),
                ),
              ],
            ),
          ),
          Divider(),
          buildImageViewButtonBar(),
          Divider(height: 0.0),
//        buildUserPosts(),
        ],
      )
    );
  }


  Row buildImageViewButtonBar() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.schedule, size: 28),
        ),
        IconButton(
          icon: Icon(Icons.restore, size: 32)
        ),
        IconButton(
            icon: Icon(Icons.payment, size: 32),
        ),
      ],
    );
  }

  Widget _getImage() {
    return Image.asset(
      'assets/add_profile_picture.png', fit: BoxFit.fitHeight, color: Colors.grey[400],);
  }
}