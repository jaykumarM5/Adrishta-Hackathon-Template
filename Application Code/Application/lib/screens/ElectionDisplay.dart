import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ElectionDisplay extends StatefulWidget {
  ElectionDisplay({@required this.search});

  final String search;
  @override
  _ElectionDisplayState createState() => _ElectionDisplayState();
}

class _ElectionDisplayState extends State<ElectionDisplay> {
// Start
  var regNo = 201800080;
  Future buildCards(search) async {
    List<Card> listOfBooks = [];
    String url = 'https://smit-libms-server.herokuapp.com/e_books/searchTab';
    var data;
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({'book_name': search}));
      if (response.statusCode != 200) {
        print('Error');
      } else {
        data = jsonDecode(response.body);
        print(data);
      }
      if (data != null) {
        print('This is Inside if');
        for (int i = 0; i < data.length; i++) {
          listOfBooks.add(
            Card(
              color: Color(0xFF0000FF),
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    leading: Text(
                      '${data[i]["book_name"]}',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${data[i]["department"]}',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
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
                        color: Color(0x550000FF),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(2, 2))
                  ],
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text(
                'Searched for : ${widget.search}',
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
                future: buildCards(widget.search),
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
            )
          ]),
        ),
      ),
    );
  }
}
