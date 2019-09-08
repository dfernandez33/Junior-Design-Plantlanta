import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/screens/home.dart';

class Preferences3 extends StatefulWidget {
  @override
  _Preferences3State createState() => _Preferences3State();
}

class _Preferences3State extends State<Preferences3> {
  PageController _pageController;
  int _page = 2;
  int _radioValue3 = -1;

  void _handleRadioValueChange3(int value) {
    setState(() {
      _radioValue3 = value; } );
  }

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
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(10),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10),
                  ),
                  new Text('Sync contacts from linked authorized accounts?', style: new TextStyle(fontSize: 16)),
                  new Divider(height: 5, color: Colors.black),
                  new Padding(padding: new EdgeInsets.all(10)),
                  new Text('Yes', style: new TextStyle(fontSize: 16)),
                  new Radio(
                    value: 1,
                    groupValue: _radioValue3,
                    onChanged: _handleRadioValueChange3,
                  ),
                  new Text('Not right now', style: new TextStyle(fontSize: 16)),
                  new Radio(
                    value: 2,
                    groupValue: _radioValue3,
                    onChanged: _handleRadioValueChange3,
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