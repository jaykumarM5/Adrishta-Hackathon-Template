import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:i_voted/Data.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future buildCard() async {
    //for storing users
    List<Widget> listOfEvents = [];
    try {
      var response = await http.get(eventsUrl);
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        try {
          var response = await http.get(
              'https://i-voted.vercel.app/api/v1/blockchain/listCandidate/' +
                  data[i]["_id"]);

          var dataEvent = jsonDecode(response.body);
          if (dataEvent != null) {
            int sumOfVotes = 0;
            List<ChartData> chartData = [];

            for (int i = 0; i < dataEvent.length; i++) {
              sumOfVotes += dataEvent[i]["votes"];
            }
            for (int i = 0; i < dataEvent.length; i++) {
              chartData.add(
                ChartData(
                  dataEvent[i]["name"],
                  double.parse(
                    (dataEvent[i]["votes"] * 100 / sumOfVotes)
                        .toStringAsFixed(2),
                  ),
                ),
              );
            }

            listOfEvents.add(
              Card(
                elevation: 20,
                color: Colors.orange,
                child: SfCircularChart(
                    title: ChartTitle(
                      text: data[i]["event"],
                    ),
                    // for Displaying the radial bar
                    legend: Legend(
                      isVisible: true,
                    ),
                    series: <CircularSeries>[
                      // Renders radial bar chart
                      RadialBarSeries<ChartData, String>(
                        dataSource: chartData,
                        // [
                        //   ChartData('David', 25),
                        //   ChartData('Steve', 38),
                        //   ChartData('Jack', 34),
                        //   ChartData('Others', 52)
                        // ],
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
              ),
            );
          }
          if (listOfEvents.length == 0) {
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
      }
    } catch (e) {
      print(e);
    }
    return listOfEvents;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
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
                'History',
                style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
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
            ),
          ],
        ),
      )),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
