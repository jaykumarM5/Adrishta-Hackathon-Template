import 'dart:html';

import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
          children: [
            SizedBox(
              height: 25.0,
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x550000FF),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Text(
                'AdminPage',
                style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                crossAxisCount: 2,
                children: [
                  GridButton(),
                  FlatButton(
                    child: Text('Ban Candidate'),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text('Ban Voter'),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text('Revoke Ban on Voter'),
                    onPressed: () {},
                  ),
                  FlatButton(
                      child: Text('Revoke Ban on Candidate'), onPressed: () {}),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class GridButton extends StatelessWidget {
  GridButton({this.text, this.url});
  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Add Candidate'),
      onPressed: () {},
    );
  }
}
