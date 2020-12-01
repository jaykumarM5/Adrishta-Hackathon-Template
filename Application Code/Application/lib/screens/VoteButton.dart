// ask if the user is ready to vote
// it is only activated when there is ongoing
// election and it navigates to the homescreen where
// user will vote

import 'package:flutter/material.dart';
import 'package:i_voted/Data.dart';

class VoteButton extends StatefulWidget {
  @override
  _VoteButtonState createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  bool enable = true;
  String msg = '';
  bool flag = false;

  void checkVoter() async {
    flag = await checkVote();
    if (flag == null) {
      flag = true;
    }
    setState(() {
      print(flag.toString());
      if (flag) {
        enable = true;
        msg = 'You are authorised to vote';
      } else {
        msg = 'You can\'t vote';
      }
    });
  }

  @override
  initState() {
    super.initState();
    checkVoter();
    // checks if the voter is applicable to vote or not
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            enable
                ? Text(
                    "Tap to Enter into Election",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.2,
                        fontWeight: FontWeight.bold),
                  )
                : Text(''),
            SizedBox(
              height: size.height * 0.07,
            ),
            Container(
              child: enable
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
                          Navigator.pushNamed(
                              context, 'electionUser'); // router
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
              "$msg",
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
