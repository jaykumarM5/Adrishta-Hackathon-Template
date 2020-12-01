import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flip_card/flip_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class History extends StatelessWidget {
  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                'Admin',
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
                future: buildCard(),
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
          ],
        ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  HistoryCard({
    @required this.chartData,
    this.votedFor,
    this.date,
  });

  final List<ChartData> chartData;
  final String votedFor;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlipCard(
          direction: FlipDirection.HORIZONTAL,
          front: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                shadowColor: Colors.purple[900],
                color: Colors.orange[900],
                child: Container(
                    height: 80,
                    color: Colors.orange[300],
                    margin: EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  'Voted FOR :',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '$votedFor',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  'DATE :',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '$date',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
          back: Center(
            child: Card(
              elevation: 20,
              shadowColor: Colors.purple[900],
              color: Colors.deepOrange,
              child: Container(
                  height: 330,
                  color: Colors.orange[200],
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Container(
                            child: Text(
                              'RESULTS',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SfCircularChart(
                              // for Displaying the radial bar
                              legend: Legend(
                                isVisible: true,
                              ),
                              series: <CircularSeries>[
                                // Renders radial bar chart
                                RadialBarSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  radius: "75%",
                                  dataLabelSettings: DataLabelSettings(
                                      // Renders the data label
                                      isVisible: true),
                                  enableSmartLabels: true,
                                  enableTooltip: true,
                                ),
                              ]),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 40),
          child: Container(child: Text('Touch to see stats')),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}

Future<List<HistoryCard>> buildCard() {
  // List<Widget> listOfEvents = [];
  //   String url = '${eventUrl}basketball';
  //   var data;
  Future.delayed(
    Duration(seconds: 5),
    () {
      return [
        HistoryCard(
          chartData: [
            ChartData('David', 25),
            ChartData('Steve', 38),
            ChartData('Jack', 34),
            ChartData('Others', 52)
          ],
          votedFor: 'President',
          date: '2020',
        ),
      ];
    },
  );
}
