import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:junior_design_plantlanta/contact.dart';
import 'package:junior_design_plantlanta/model/registration_model.dart';
import 'package:junior_design_plantlanta/screens/preferences1_screen.dart';
//import 'package:junior_design_plantlanta/contact_services.dart';

class Registration extends StatefulWidget {
  // This widget is the root of your application.
  Registration({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RegistrationState createState() => new _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  UserRegistrationModelBuilder newContact;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();

  String name1 = 'roberto';
  String dob1 = '';
  String phone1 = '';
  String email1 = '';
  String password1 = '';

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now) ? initialDate : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try
    {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  Future<void> preferences1() async {
    try {
      newContact = UserRegistrationModelBuilder()
        ..dob = dob1
        ..password = password1
        ..name = name1
        ..phone = phone1
        ..email = email1;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Preferences1(newContact)));
    } catch (e) {
      print(e.message);
    }
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  bool isValidPhoneNumber(String input) {
    final RegExp regex = new RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return regex.hasMatch(input);
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  bool isValidPassword(String input) {
    final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]$");
    return regex.hasMatch(input);
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;
    form.save();
//
//    if (!form.validate()) {
//      //showMessage('Form is not valid!  Please review and correct.');
//    } else {
//      form.save(); //This invokes each onSaved event
//
////      print('Form save called, newContact is now up to date...');
////      print('Name: ${newContact.name}');
////      print('Dob: ${newContact.dob}');
////      print('Phone: ${newContact.phone}');
////      print('Email: ${newContact.email}');
////      print('========================================');
////      print('Submitting to back end...');
//      //var contactService = new ContactService();
//      //contactService.createContact(newContact)
//      //    .then((value) =>
//      //    showMessage('New contact created for ${value.name}!', Colors.blue)
//      //);    }
//    }
  }

//  void showMessage(String message, [MaterialColor color = Colors.red]) {
//    _scaffoldKey.currentState
//        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Plantlanta"),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'Name is required' : null,
                    //onSaved: (val) => newContact.rebuild((b) => b.name = val),
                      onSaved: (val) => name1 = val,
                  ),
                  new Row(children: <Widget>[
                    new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.calendar_today),
                            hintText: 'Enter your date of birth',
                            labelText: 'Date of birth',
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.datetime,
                          validator: (val) =>
                          isValidDob(val) ? null : 'Not a valid date',
                          //onSaved: (val) => newContact.rebuild((b) => b.dob = val),
                          onSaved: (val) => dob1 = val,
                        )),
                    new IconButton(
                      icon: new Icon(Icons.more_horiz),
                      tooltip: 'Choose date',
                      onPressed: (() {
                        _chooseDate(context, _controller.text);
                      }),
                    )
                  ]),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      new WhitelistingTextInputFormatter(
                          new RegExp(r'^[()\d -]{1,15}$')),
                    ],
                    validator: (value) => isValidPhoneNumber(value)
                        ? null
                        : 'Phone number must be entered as (###)###-####',
                    //onSaved: (val) => newContact.rebuild((b) => b.phone = val),
                    onSaved: (val) => phone1 = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => isValidEmail(value)
                        ? null
                        : 'Please enter a valid email address',
                    //onSaved: (val) => newContact.rebuild((b) => b.email = val),
                    onSaved: (val) => email1 = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.lock_open),
                      hintText: 'Enter a password',
                      labelText: 'Password',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'Password is required' : null,
                    //onSaved: (val) => newContact.rebuild((b) => b.password = val),
                    onSaved: (val) => password1 = val,
                    obscureText: true,
                    //onSaved: (val) => newContact.password = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.lock_outline),
                      hintText: 'Re-enter your password',
                      labelText: 'Confirm your password',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'Password is required' : null,
                    obscureText: true,
                    //onSaved: (val) => newContact.password = val,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: (){
                          _submitForm();
                          preferences1();
                        },
                      )),
                ],
              ))),
    );
  }
}