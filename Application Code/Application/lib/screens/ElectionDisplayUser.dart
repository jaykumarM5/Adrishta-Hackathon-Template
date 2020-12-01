import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:i_voted/Data.dart';
import 'package:i_voted/screens/AdminPage.dart';
import 'package:i_voted/screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ElectionDisplayUser extends StatefulWidget {
  @override
  _ElectionDisplayUserState createState() => _ElectionDisplayUserState();
}

class _ElectionDisplayUserState extends State<ElectionDisplayUser> {
// Start
  bool color;
  Future buildCards() async {
    List<Widget> listOfBooks = [];
    var data;
    try {
      var response = await http.get(eventsUrl);
      if (response.statusCode != 200) {
        print('Error');
      } else {
        data = jsonDecode(response.body);
        print(data);
      }
      if (data != null) {
        print('This is Inside if');
        for (int i = 0; i < data.length; i++) {
          if (i % 2 == 0) {
            setState(() {
              color = true;
            });
          } else {
            setState(() {
              color = false;
            });
          }
          listOfBooks.add(
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(id: data[i]["_id"]),
                  ),
                );
              },
              child: Card(
                color: color ? Colors.orange[100] : Colors.white,
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          '${data[i]["event"]}',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(child: Text('tap to see result')),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }
      if (listOfBooks.length == 0) {
        print('This is Else');
        listOfBooks.add(
          Card(
            margin: EdgeInsets.all(10.0),
            elevation: 10.0,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Text(
                "No Results Found",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
      print('This is catch');
    }
    print(listOfBooks.length);
    return listOfBooks;
  }

// End

  bool isSpin;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(children: [
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
                'Home',
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
              child: FutureBuilder(
                future: buildCards(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data,
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
