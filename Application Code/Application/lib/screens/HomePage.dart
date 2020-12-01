import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:i_voted/Data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  HomePage({this.id});
  final String id;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> listofCandidate = [];
  var data; // for storing fetched data
  Future<List> getData(size) async {
    // change the return type to future when getting data using http
    try {
      var response = await http.get(candidateListUrl + widget.id);
      print(response.body);
      data = json.decode(response.body);
    } catch (e) {
      print(e);
    }
    bool isPressed = true;
    for (int i = 0; i < data.length; i++) {
      if (i % 2 == 0) {
        // if else block is used to provide different color of 2 consecutive
        setState(() {
          // rows
          isPressed = true;
        });
      } else {
        setState(() {
          isPressed = false;
        });
      }
      listofCandidate.add(
        RaisedButton(
            onPressed: () {
              print(isPressed);
              vote(email, data[i]["name"]);
              Fluttertoast.showToast(msg: 'Done');
            }, // if the button is pressed the color of the button changes
            // color:  ? Colors.green : Colors.white,  // for 2 sec and then the it will be navigated to polls page
            child: Card(
              // where stats of ongoing election will be displayed on real time
              elevation: 10,
              shadowColor: Colors.black,
              // color: Colors.red,
              color: isPressed ? Colors.white : Colors.green[100],
              child: Card(
                child: ListTile(
                  tileColor: isPressed ? Colors.white : Colors.green[100],
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    minRadius: size.width * 0.15,
                    maxRadius: size.width * 0.15,
                    child: Text(
                      'V',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Piedra',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: Text(
                    '${data[i]["bio"]}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Piedra'),
                  ),
                  title: Text(
                    '${data[i]["name"]}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Piedra'),
                  ),
                ),
              ),
            )),
      );
    }
  }

  var flag = true; // when there is election is will be true

  initState() {
    super.initState();
    getData(Size(360.0, 640.0)); // get this size by router navigation
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);

    return SafeArea(
      child: Scaffold(
        body: Column(
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
                'Candidate List',
                style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Container(
                child: Center(
              child: flag
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.purple,
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: listofCandidate)),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text('No ongoing election'),
                    ),
            )),
          ],
        ),
      ),
    );
  }
}
