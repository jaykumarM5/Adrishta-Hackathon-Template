import 'package:flutter/material.dart';
import 'package:i_voted/screens/OTPPage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/services.dart';
import 'package:i_voted/Data.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSpin = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          // statusBarColor: Color(0xFF5200FF),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.orange,
          systemNavigationBarIconBrightness: Brightness.light),
    );
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isSpin,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'I V',
                          style: TextStyle(fontFamily: 'Piedra', fontSize: 150),
                        ),
                        Text(
                          'O T E D',
                          style: TextStyle(fontFamily: 'Piedra', fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: size.width * 0.30,
                        decoration: BoxDecoration(
                          // color: Color(0xFFB5A9FF),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x550000A0),
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                                offset: Offset(2, 1))
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.15),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          minRadius: size.width * 0.15,
                          maxRadius: size.width * 0.15,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'Piedra',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Email Text Box
                      Container(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        margin: EdgeInsets.only(right: 10, left: 10, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Colors.grey[200],
                        ),
                        child: Material(
                          elevation: 20.0,
                          shadowColor: Colors.grey[900],
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            showCursor: true,
                            style: TextStyle(fontSize: 20),
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              suffixText: '@smit.smu.edu.in',
                              suffixStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              hintStyle: TextStyle(),
                              hintText:
                                  '                   Email', //var hintText
                              fillColor: Colors.white,
                              filled: true,
                              // contentPadding:
                              //     EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),

                      // Request OTP Button
                      Material(
                        color: Color(0xFFB5A9FF),
                        elevation: 20,
                        shadowColor: Colors.grey[900],
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        child: FlatButton(
                          onPressed: () async {
                            setState(() {
                              isSpin = true;
                            });
                            if (email != '') {
                              await login();
                              isSpin = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPPage(email, otp),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              'Request OTP',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                  SizedBox(height: 50), //var login
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
