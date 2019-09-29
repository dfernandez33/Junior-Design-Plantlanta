import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_design_plantlanta/screens/preferences1_screen.dart';
import 'package:junior_design_plantlanta/screens/registration.dart';

class LoginPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF25A325)),
        ),
        body: Form(
            key: _formKey,
            child: new Container(
              width: double.infinity,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                        right: 0.0, left: 0.0, bottom: 10.0),
                    child: Image.asset(
                      'assets/logo.jpeg',
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 1.0),
                    child: new TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please type your email address.';
                        } else if (!input.contains('@') ||
                            !input.contains('.')) {
                          return 'Email is invalid.';
                        }
                      },
                      onSaved: (input) => _email = input,
                      decoration: new InputDecoration(labelText: 'Email'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: new TextFormField(
                      obscureText: true,
                      onSaved: (input) => _password = input,
                      validator: (input) {
                        if (input.length < 6) {
                          return 'Please provide a password at least 6 characters long.';
                        }
                      },
                      decoration: new InputDecoration(labelText: 'Password'),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            right: 0.0, left: 0.0, top: 10.0),
                        child: FlatButton(
                          onPressed: signIn,
                          child: Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              decoration: new BoxDecoration(
                                color: Color(0xFF25A325),
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "Login",
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      )),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 5.0, left: 5.0, top: 10.0),
                              child: FlatButton(
                                onPressed: recoverPassword,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60.0,
                                  child: Text(
                                    "Forgot Password?",
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF25A325)),
                                  ),
                                ),
                              )))
                    ],
                  ),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: FlatButton(
                                onPressed: register,
                                child: new Text(
                                  "Create a New Account",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Color(0xFF25A325)),
                                ),
                              ))
                        ]),
                  ),
                ],
              ),
            )));
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
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
    }
  }

  Future<void> recoverPassword() async {
    final formState = _formKey.currentState;
    formState.save();
    if (_email != null && _email.contains('@') && _email.contains('.')) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      } catch (e) {
        print(e.message);
      }
    } else {
      _showDialog();
    }
  }

  Future<void> register() async {
    try {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
    } catch (e) {
      print(e.message);
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Missing Email, Oops!"),
          content: new Text("Please type in your email into the email "
              "field so we can send you a password recovery email."),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "close",
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xFF25A325)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
