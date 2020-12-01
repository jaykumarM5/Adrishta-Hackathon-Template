import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flip_card/flip_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future buildCard() async {
    //for storing users
    List<Widget> listOfEvents = [];
    var data;
    try {
      var response = await http.post(
          'https://i-voted.vercel.app/api/v1/blockchain/voteHistory/rishabh_1253/get');

      data = jsonDecode(response.body);
      print(data);
      if (data != null) {
        print('This is Inside if');
        for (int i = 0; i < data.length; i++) {
          listOfEvents.add(Card(
            elevation: 20,
            color: Colors.orange,
            child: SfCircularChart(
                // for Displaying the radial bar
                legend: Legend(
                  isVisible: true,
                ),
                series: <CircularSeries>[
                  // Renders radial bar chart
                  RadialBarSeries<ChartData, String>(
                    dataSource: [
                      ChartData('David', 25),
                      ChartData('Steve', 38),
                      ChartData('Jack', 34),
                      ChartData('Others', 52)
                    ],
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
          ));
        }
      }
      if (listOfEvents.length == 0) {
        print('This is Else');
        listOfEvents.add(
          Card(
            margin: EdgeInsets.all(10.0),
            elevation: 10.0,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Text(
                "There Are Users",
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
    print(listOfEvents.length);
    return listOfEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
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
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
