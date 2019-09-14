import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/screens/home.dart';
import 'package:barcode_scan/barcode_scan.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Plantlanta"),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Home(1),
          Home(2),
          Home(3),
          Home(4),
          Home(5),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7),
            IconButton(
              icon: Icon(
                Icons.home,
                size: 24.0,
              ),
              color: _page == 0
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => navigationTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.label,
                size: 24.0,
              ),
              color: _page == 1
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => navigationTapped(1),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                size: 24.0,
                color: Theme.of(context).primaryColor,
              ),
              color: _page == 2
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => navigationTapped(2),
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                size: 24.0,
              ),
              color: _page == 3
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => navigationTapped(3),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 24.0,
              ),
              color: _page == 4
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => navigationTapped(4),
            ),
            SizedBox(width: 7),
          ],
        ),
        color: Theme.of(context).backgroundColor,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.center_focus_weak,
          color: Theme.of(context).backgroundColor,
        ),
        onPressed: scan,
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

  Future<void> scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);

      final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'confirmEvent',
      );

      try {
        final HttpsCallableResult result =
            await callable.call(<String, dynamic>{"EventID": barcode});

        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              //TODO: create pop-up confirmation with event confirmation data
              title: new Text("Confirmed for: ${result.data}"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

      } catch (e) {
        print(e.message);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("${e.message}"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }

    print(this.barcode);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
