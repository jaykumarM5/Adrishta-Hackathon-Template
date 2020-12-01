// ask if the user is ready to vote
// it is only activated when there is ongoing 
// election and it navigates to the homescreen where 
// user will vote


import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.enable, this.msg}) : super(key: key);

  final bool enable;
  final String msg;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: widget.enable
                  ? Ink(
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.thumb_up_alt,
                          color: Colors.blue[400],
                        ),
                        iconSize: 150.0,
                        splashColor: Colors.red[400],
                        padding: EdgeInsets.all(40.0),
                        onPressed: () {
                          Navigator.pushNamed(context, ''); // router
                        },
                      ))
                  : Ink(
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: CircleBorder(),
                      ),
                      child: IconsReturn()),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
            ),
            Text(
              "${widget.msg}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.2,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class IconsReturn extends StatelessWidget {
  const IconsReturn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: Colors.red[400],
      ),
      iconSize: 150.0,
      padding: EdgeInsets.all(40.0),
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('You are not authorised to vote'),
        ));
      },
    );
  }
}

