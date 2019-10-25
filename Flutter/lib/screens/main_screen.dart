import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/model/event_model.dart';
import 'package:junior_design_plantlanta/screens/home.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:junior_design_plantlanta/screens/marketplace.dart';
import 'package:junior_design_plantlanta/serializers/StatusResponse.dart';
import 'package:junior_design_plantlanta/services/user_service.dart';
import 'package:junior_design_plantlanta/widgets/progress_dialog.dart';

import 'package:junior_design_plantlanta/screens/login.dart';


class MainScreen extends StatefulWidget {
  UserService _userService;
  MainScreen() {
    this._userService = UserService();
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;
  String barcode = "";
  bool isConfirmedClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Plantlanta"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app),
            onPressed: (){ _logOut();},
          ),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Home(1),
          Marketplace(widget._userService),
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
                Icons.shopping_cart,
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
        this.barcode = barcode;
      
      final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'getEvent',
      );

      try {
        final HttpsCallableResult result = await callable
            .call(<String, dynamic>{"EventID": this.barcode});

        StatusResponse resp = new StatusResponse.fromJson(result.data);

        EventModel event;
        if (resp.status == 1) {
          event = EventModel.fromJson(resp.message);
        }

        var user = await FirebaseAuth.instance.currentUser();

        if (event.participants.contains(user.uid)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return ProgressDialog(
                  confirmAttendance,
                  _buildContentPopUpConfirmation(event),
                  "Confirm",
                  "Confirm attendance for ${event.name}?",
                  false);
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ProgressDialog(
                  null,
                  Text(
                      "Please sign up for the event before confirming your attendence."),
                  "Close",
                  "Looks like you aren't signed up!",
                  false);
            },
          );
        }
      } catch (e) {
        print(e.message);
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
  }

  Widget _buildContentPopUpConfirmation(EventModel event) {
    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        child: Row(
          children: <Widget>[
            Container(
                child: Text("Start Time: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor))),
            Container(
                child: Text(event.startTime)),
          ],
        ),
      ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    child: Text("End Time: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor))),
                Container(
                    child: Text(event.endTime)),
              ],
            ),
          ),
      Container(
        child: Row(
          children: <Widget>[
            Container(
                child: Text("Location: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor))),
            Container(child: Text("${event.location}")),
          ],
        ),
      ),
      Container(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text("${event.description}")),
    ]));
  }

  Future<void> confirmAttendance() async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'confirmEvent',
    );
    try {
      final HttpsCallableResult result = await callable
          .call(<String, dynamic>{"EventID": this.barcode});

      StatusResponse resp = new StatusResponse.fromJson(result.data);
      Navigator.of(context).pop();

      if (resp.status == 1) {
        print('success');
      } else {
        print('error');
      }
    } catch (e) {
      print(e.message);
    }
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  Future<void> _logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      Navigator.of(context).pop();
    } catch (e) {
      print(e.message);
    }
  }
}

