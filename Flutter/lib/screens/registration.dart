import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:junior_design_plantlanta/model/registration_model.dart';
import 'package:junior_design_plantlanta/screens/preferences1_screen.dart';

class Registration extends StatefulWidget {
  // This widget is the root of your application.
  Registration({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RegistrationState createState() => new _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  UserRegistrationModelBuilder newUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  final TextEditingController _controller = new TextEditingController();
  final _UsNumberTextInputFormatter _phoneNumberFormatter = new _UsNumberTextInputFormatter();

  String name1 = '';
  String dob1 = '';
  String phone1 = '';
  String email1 = '';
  String password1 = '';
  String address1 = '';

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
      var parsedDate = new DateFormat.yMd().parseStrict(input);
      return parsedDate;
    } catch (e) {
      return null;
    }
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var parsedDate = convertToDate(dob);
    return parsedDate != null && parsedDate.isBefore(new DateTime.now());
  }

  bool isValidPhoneNumber(String input) {
    final RegExp regex = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    return regex.hasMatch(input);
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  bool isValidPassword(String input) {
    final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]$");
    return regex.hasMatch(input) && input.length > 5;
  }

  bool confirmPassword(String input, String passwordCheck) {
    passwordCheck = newUser.password;
    return input == passwordCheck;
  }

  void _submitForm() {
    final formstate = _formKey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        newUser = UserRegistrationModelBuilder()
          ..dob = dob1
          ..password = password1
          ..name = name1
          ..phone = phone1
          ..address = address1
          ..email = email1;

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Preferences1(newUser)));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }

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
              autovalidate: false,
              //padding: const EdgeInsets.only(),
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top:15)),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (name) => name.isEmpty ? 'Name is required' : null,
                    //onSaved: (val) => newContact.rebuild((b) => b.name = val),
                    onSaved: (name) => name1 = name,
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
                          validator: (dob) =>
                          isValidDob(dob) ? null : 'Not a valid date',
                          //onSaved: (val) => newContact.rebuild((b) => b.dob = val),
                          onSaved: (dob) => dob1 = dob,
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
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                      _phoneNumberFormatter,
                      new LengthLimitingTextInputFormatter(14)
                    ],
                    validator: (phone) => isValidPhoneNumber(phone)
                        ? null
                        : 'Phone number must be entered as digits only',
                    //onSaved: (val) => newContact.rebuild((b) => b.phone = val),
                    onSaved: (phone) => phone1 = phone,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.home),
                      hintText: 'Enter your address',
                      labelText: 'Address',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (address) => address.isEmpty ? 'Address is required' : null,
                    //onSaved: (val) => newContact.rebuild((b) => b.password = val),
                    onSaved: (address) => address1 = address,
                    //onSaved: (val) => newContact.password = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter an email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) => isValidEmail(email)
                        ? null
                        : 'Please enter a valid email address',
                    //onSaved: (val) => newContact.rebuild((b) => b.email = val),
                    onSaved: (email) => email1 = email,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.lock_open),
                      hintText: 'Enter a password',
                      labelText: 'Password',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (password) => password.length < 6 ? 'Password must be at least 6 characters' : null,
                    onSaved: (password) => password1 = password,
                    obscureText: true,
                    key: passKey,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.lock_outline),
                      hintText: 'Re-enter your password',
                      labelText: 'Confirm your password',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (confirmation) => (confirmation == passKey.currentState.value.toString()) ? null : 'Passwords dont match',
                    obscureText: true,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 0, top: 40.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: (){
                          _submitForm();
                        },
                      )),
                ],
              ))),
    );
  }
}

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1)
        selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3)
        selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6)
        selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10)
        selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}