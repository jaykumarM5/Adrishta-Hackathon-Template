import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:i_voted/Data.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 25),
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
                'Developers',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.green,
                      Colors.white,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30),
                    NameBoxAboutPage(
                        'assets/images/pic3.jpg',
                        'Suraj Kumar Ojha\n',
                        'B.Tech _CSE',
                        '$surajLinkedIn',
                        '$surajInsta'),
                    NameBoxAboutPage('assets/images/pic4.jpg', 'Jay Kumar\n',
                        'B.Tech _CSE', '$jayLinkedIn', '$jayInsta'),
                    NameBoxAboutPage('assets/images/pic5.jpg', 'Rishabh\n',
                        'B.Tech _IT', '$rishabhLinkedIn', '$rishabhInsta'),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NameBoxAboutPage extends StatefulWidget {
  NameBoxAboutPage(
      this.pic, this.name, this.branch, this.linkedInId, this.instagram);
  final name;
  final branch;
  final pic;
  final linkedInId;
  final instagram;
  @override
  _NameBoxAboutPageState createState() => _NameBoxAboutPageState();
}

class _NameBoxAboutPageState extends State<NameBoxAboutPage> {
  Future<void> _launched;
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        // forceSafariVC: false,
        // forceWebView: true,
        // enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 15,
        shadowColor: Colors.purple[900],
        margin: EdgeInsets.fromLTRB(7, 0, 7, 20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(7, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 0,
              ),
              SizedBox(
                width: 75,
                child: Image(
                  image: AssetImage(widget.pic),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                        TextSpan(
                            text: widget.name,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Billabong',
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: widget.branch,
                            style: TextStyle(fontSize: 15)),
                      ]))
                ],
              ),
              Expanded(child: SizedBox()),
              FloatingActionButton(
                  mini: true,
                  heroTag: null,
                  backgroundColor: Colors.blue[700],
                  onPressed: () {
                    setState(() {
                      _launched = _launchInBrowser(widget.instagram);
                    });
                  },
                  child: SizedBox(
                    height: 57,
                    width: 56,
                    child: Image.asset('assets/images/instagram.png'),
                  )),
              FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.blue[700],
                  onPressed: () {
                    setState(() {
                      _launched = _launchInBrowser(widget.linkedInId);
                    });
                  },
                  child: SizedBox(
                    height: 57,
                    width: 56,
                    child: Image.asset('assets/images/icon_pic.png'),
                  )),
              SizedBox(width: 15)
            ],
          ),
        ),
      ),
    );
  }
}
