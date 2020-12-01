import 'package:flutter/material.dart';
import 'package:i_voted/screens/AboutPage.dart';
import 'screens/HomePage.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:i_voted/screens/History.dart';
import 'package:i_voted/screens/VoteButton.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  PageController _myPage = PageController(initialPage: 1);
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        color: Colors.orange,
        // shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                    currentIndex = 0;
                    print(currentIndex);
                  });
                },
                iconSize: currentIndex == 0 ? 35 : 25.0,
                padding: EdgeInsets.only(right: 10.0, left: 30),
                icon: Icon(
                  Icons.history,
                  color:
                      currentIndex == 0 ? Colors.white : Colors.deepOrange[600],
                ),
              ),
              SizedBox(
                width: size.width * 0.1,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                    currentIndex = 1;
                    print(currentIndex);
                  });
                },
                iconSize: currentIndex == 1 ? 35 : 25.0,
                padding: EdgeInsets.only(left: 10.0, right: 10),
                icon: Icon(FlutterIcons.home_ant,
                    color: currentIndex == 1
                        ? Colors.white
                        : Colors.deepOrange[600]),
              ),

              SizedBox(
                width: size.width * 0.1,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(2);
                    currentIndex = 2;
                    print(currentIndex);
                  });
                },
                iconSize: currentIndex == 2 ? 35 : 25.0,
                padding: EdgeInsets.only(left: 10.0, right: 20),
                icon: Icon(Icons.help,
                    color: currentIndex == 2
                        ? Colors.white
                        : Colors.deepOrange[600]),
              ),
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       _myPage.jumpToPage(3);
              //       currentIndex = 3;
              //       print(currentIndex);
              //     });
              //   },
              //   iconSize: currentIndex == 3 ? 35 : 25.0,
              //   padding: EdgeInsets.only(right: 20.0, left: 10),
              //   icon: Icon(Icons.settings,
              //       color:
              //           currentIndex == 3 ? Colors.white : Colors.green),
              // )
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _myPage,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [History(), VoteButton(), About()],
        // physics: NeverScrollableScrollPhysics(),
        physics: BouncingScrollPhysics(),
      ),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          heroTag: false,
          backgroundColor: Colors.deepOrange[600],
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', '');
            prefs.setString('role', '');
            Navigator.pushNamed(context, 'login');
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
