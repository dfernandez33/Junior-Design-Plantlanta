import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/screens/home.dart';

class Preferences2 extends StatefulWidget {
  @override
  _Preferences2State createState() => _Preferences2State();
}

class _Preferences2State extends State<Preferences2> {
  PageController _pageController;
  int _page = 1;
  Map<String, bool> volunteerType = {
    'Sporadically': false,
    'Recurringly': false,
  };

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
        padding: new EdgeInsets.all(10),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 40, right: 10),
                  child: Text(
                    "How often would you like to volunteer?",
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
                padding: EdgeInsets.only(top: 20),
                children: volunteerType.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    //padding: EdgeInsets.only(top: 10),
                    value: volunteerType[key],
                    onChanged: (bool value) {
                      setState(() {
                        volunteerType[key] = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            new Row(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "In what area would you like to volunteer?",
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
                padding: EdgeInsets.only(top: 20, bottom: 30),
                children: location.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    //padding: EdgeInsets.only(top: 10),
                    value: location[key],
                    onChanged: (bool value) {
                      setState(() {
                        location[key] = value;
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