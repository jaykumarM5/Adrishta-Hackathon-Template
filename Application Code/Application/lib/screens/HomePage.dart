import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var flag = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Center(
          child: flag?Center(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(height: size.height*0.40,
              child: Card(elevation: 10,shadowColor: Colors.purple,child: 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                  InkWell(onTap: (){},child: Card(elevation: 10,shadowColor: Colors.black,child: Container(height:size.height*0.10,width: size.width*0.90,),)),
                  InkWell(onTap: (){},child: Card(elevation: 10,shadowColor: Colors.black,child: Container(height:size.height*0.10,width: size.width*0.90,),)),
                  InkWell(onTap: (){},child: Card(elevation: 10,shadowColor: Colors.black,child: Container(height:size.height*0.10,width: size.width*0.90,),))
                ],),
              ),),
            ),
          ),):
          Center(child: Text('No ongoing election'),),
        )),
      ),
    );
  }
}
