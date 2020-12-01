import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:i_voted/Data.dart';

class Lists extends StatefulWidget {
  Lists(
      {this.title,
      this.url,
      this.id}); // gets the title and the url for fetching users
  final title;
  final url;
  final String id;
  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
// Start
  Future buildCards(size) async {
    List<Widget> listOfUsers = []; //for storing users

    var data;
    try {
      try {
        var response = await http.get(candidateListUrl + widget.id);
        print(response.body);
        print('Candidate List');
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
        listOfUsers.add(
          Card(
            // where stats of ongoing election will be displayed on real time
            elevation: 10,
            shadowColor: Colors.black,
            // color: Colors.red,
            color: isPressed ? Colors.white : Colors.green[100],
            child: Card(
              child: ListTile(
                tileColor: isPressed ? Colors.white : Colors.green[100],
                trailing: Text(
                  '${data[i]["bio"]}',
                  style: TextStyle(
                      color: Colors.black, fontSize: 18, fontFamily: 'Piedra'),
                ),
                leading: Text(
                  '${data[i]["name"]}',
                  style: TextStyle(
                      color: Colors.black, fontSize: 18, fontFamily: 'Piedra'),
                ),
                subtitle: Text(
                  'Tap to vote',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      if (listOfUsers.length == 0) {
        print('This is Else');
        listOfUsers.add(
          Card(
            margin: EdgeInsets.all(10.0),
            elevation: 10.0,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Text(
                "There Are No Candidates",
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
    print(listOfUsers.length);
    return listOfUsers;
  }

// End

  bool isSpin;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              ),
              child: Text(
                widget.title,
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
                future: buildCards(size),
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
