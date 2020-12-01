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
  bool color;
  Future buildCards(search) async {
    List<Card> listOfBooks = [];
    String url = '';
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
            Card(
              color: color ? Colors.orange[400] : Colors.orange[200],
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
                        '${data[i]["book_name"]}',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
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
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: FloatingActionButton(
                      onPressed: () {},
                      heroTag: false,
                      backgroundColor: Colors.orange[700],
                      child: Icon(Icons.logout),
                    ),
                  ),
                  Container(
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.orange[700],
                      child: Icon(Icons.add),
                      heroTag: false,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
