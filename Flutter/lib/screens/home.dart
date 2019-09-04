import 'package:flutter/material.dart';

import 'package:junior_design_plantlanta/widgets/event_card.dart';

class Home extends StatefulWidget {
  // TODO: Remove param after final implementation.
  int _number;

  Home(this._number);

  @override
  _HomeState createState() => _HomeState(this._number);
}

class _HomeState extends State<Home> {
  int _number;

  _HomeState(this._number);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventCard(),
    );
  }
}