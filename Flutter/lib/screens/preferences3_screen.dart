import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/screens/home.dart';

class Preferences3 extends StatefulWidget {
  @override
  _Preferences3State createState() => _Preferences3State();
}

class _Preferences3State extends State<Preferences3> {
  PageController _pageController;
  int _page = 2;
  Map<String, bool> friends = {
    'Sync contacts from linked authorized account?': false,
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
                  padding: const EdgeInsets.only(left: 40, top: 60, right: 10),
                  child: Text(
                    "Volunteering is more fun with friends!",
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
                children: friends.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    value: friends[key],
                    onChanged: (bool value) {
                      setState(() {
                        friends[key] = value;
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
        onPressed: () => navigationTapped(2),
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