import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class Result extends StatefulWidget {
  Result({this.id});
  final String id;
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future buildCard() async {
    //for storing users
    List<Widget> listOfCards = [];
    int sumOfVotes = 0;
    var data;
    List<ChartData> chartData = [];
    try {
      var response = await http.get(
          'https://i-voted.vercel.app/api/v1/blockchain/listCandidate/' +
              widget.id);

      data = jsonDecode(response.body);
      if (data != null) {
        for (int i = 0; i < data.length; i++) {
          sumOfVotes += data[i]["votes"];
        }
        for (int i = 0; i < data.length; i++) {
          chartData.add(
              ChartData(data[i]["name"], data[i]["votes"] * 100 / sumOfVotes));
        }
        listOfCards.add(Card(
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
                  dataSource: chartData,
                  /*[
                    ChartData('David', 25),
                    ChartData('Steve', 38),
                    ChartData('Jack', 34),
                    ChartData('Others', 52)
                  ],*/
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
      if (listOfCards.length == 0) {
        listOfCards.add(
          Card(
            margin: EdgeInsets.all(10.0),
            elevation: 10.0,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Text(
                "No result available",
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
    return listOfCards;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                'Result',
                style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: size.height * 0.2),
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
