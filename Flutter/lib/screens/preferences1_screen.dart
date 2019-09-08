import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/screens/home.dart';
import 'package:junior_design_plantlanta/screens/preferences2_screen.dart';

class Preferences1 extends StatefulWidget {
  @override
  _Preferences1State createState() => _Preferences1State();
}

class _Preferences1State extends State<Preferences1> {
  PageController _pageController;
  int _page = 0;
  Map<String, bool> interests = {
    'Education': false,
    'Environmental Sustainability': false,
    'Community Improvement': false,
    'Event Organizing': false,
    'Elderly': false,
    'Orphanages': false,
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
        padding: new EdgeInsets.all(10),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 60, right: 10),
                  child: Text(
                    "Which of the following would you like to work with?",
                    style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            new Expanded(
              child: new ListView(
              padding: EdgeInsets.only(top: 70),
              children: interests.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(key),
                value: interests[key],
                onChanged: (bool value) {
                setState(() {
                interests[key] = value;
                });
              },
            );
        }).toList(),
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
        onPressed: () { preferences2(); },
      ),
    );
  }

  void navigationTapped(int page) {
    onPageChanged(page);
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Future<void> preferences2() async {
    try {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Preferences2()));
    } catch (e) {
      print(e.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}