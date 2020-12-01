
// photo of the winning candidate will be stacked on the top of radial graph

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flip_card/flip_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class History extends StatelessWidget {
  final List<ChartData> chartData = [ // get the data through the api
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Stack(  //Stack is used for stacking up the profile pic 
          children: [  // of the candidate and radial graph.
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
                                      'TODO :',
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
                                      'TODO :',
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              )
                            ],
                          ),
                          Stack(
                            children: [
                              SfCircularChart(series: <CircularSeries>[
                                // Renders radial bar chart
                                RadialBarSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    radius: "75%")
                              ]),
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 48.0, horizontal: 40),
              child: Container(child: Text('touch to see stats')),
            )
          ],
        )),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
