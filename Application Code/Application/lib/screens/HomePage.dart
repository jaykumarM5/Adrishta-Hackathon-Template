import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> listofCandidate = [];
  List data = [
    // Fetch the candidate list here
    {"name": "Suraj Kumar Ojha", "logolink": "LOGO"},
    {"name": "Jay Kumar", "logolink": "LOGO"},
    {"name": "Rishabh", "logolink": "LOGO"},
    {"name": "Abhishek", "logolink": "LOGO"},
    {"name": "Adi", "logolink": "LOGO"}
  ];
  List getData(size) {
    for (int i = 0; i < data.length; i++) {
      listofCandidate.add(
        InkWell(
            onTap: () {},
            child: Card(
              elevation: 10,
              shadowColor: Colors.black,
              child: Container(
                height: size.height * 0.12,
                width: size.width * 0.90,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.orange,
                          minRadius: size.width * 0.15,
                          maxRadius: size.width * 0.15,
                          child: Text(
                            '${data[i]["logolink"]}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'Piedra',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          '${data[i]["name"]}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Piedra'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0,
                    )
                  ],
                ),
              ),
            )),
      );
    }
  }

  var flag = true; // when there is election is will be true

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getData(size);
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
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.purple,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: listofCandidate),
                            ),
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
