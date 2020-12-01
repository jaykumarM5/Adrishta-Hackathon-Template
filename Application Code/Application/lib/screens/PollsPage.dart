// Stats will we shown when user vote to any candidate otherwise it will not be visible


import 'package:flutter/material.dart';

class PollsPage extends StatefulWidget {
  @override
  _PollsPageState createState() => _PollsPageState();
}

class _PollsPageState extends State<PollsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Center(
          child: Text('Polls'),
        )),
      ),
    );
  }
}
