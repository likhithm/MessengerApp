import 'package:flutter/material.dart';


class DataViz extends StatefulWidget {
  final String currentUserId;

  DataViz(this.currentUserId);

  @override
  State createState() => new DataVizState();
}

class DataVizState extends State<DataViz> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Dashboard',
          style: TextStyle(color: Colors.lightBlue),
        ),
        //centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:Colors.lightBlue),
      ),
      body: new Container()
    );
  }
}
