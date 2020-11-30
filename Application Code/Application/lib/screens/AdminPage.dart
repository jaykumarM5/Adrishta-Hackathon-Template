import 'package:flutter/material.dart';
import 'package:i_voted/Data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
                    color: Colors.grey[300],
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
                'Admin',
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
              child: Container(
                padding: EdgeInsets.only(top: 30),
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400], //Color(0x550000FF),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  children: [
                    // Admin Control Buttons
                    GridButton(
                      text: 'Add Candidate',
                    ),
                    GridButton(text: 'Ban Candidate'),
                    GridButton(text: 'Ban Voter'),
                    GridButton(text: 'Revoke Ban on Voter'),
                    GridButton(text: 'Revoke Ban on Candidate'),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

// Grid View Buttons for admin

class GridButton extends StatelessWidget {
  GridButton({this.text, this.url});
  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.deepOrange[50],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300], //Color(0x550000FF),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
      onPressed: () {
        Alert(
          context: context,
          title: text,
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  tempEmail = value;
                  tempEmail += '@smit.smu.edu.in';
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.orange,
                  ),
                  hintText: 'Email',
                  suffixText: '@smit.smu.edu.in',
                  suffixStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
                color: Colors.orange,
                child: Text('Confirm'),
                onPressed: () {
                  print(tempEmail);
                }),
          ],
        ).show();
      },
    );
  }
}
