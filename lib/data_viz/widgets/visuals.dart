import 'dart:async';
import 'dart:ui';
import 'package:Connect/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:animated_text_kit/animated_text_kit.dart';

class Visuals extends StatefulWidget {
  final String peerId;
  final double hoursSpentToday;

  Visuals(this.peerId,this.hoursSpentToday);

  @override
  _Visuals createState() => new _Visuals(peerId: this.peerId);
}

class Messages {
  final int index;
  final int total;
  final String type;

  Messages(this.index, this.type, this.total);
}

class _Visuals extends State<Visuals> {
  final String peerId;

  List<charts.Series> seriesList;
  final bool animate = true;

  _Visuals({Key key, this.peerId});

  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
          future: getData(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Show');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
              case ConnectionState.done:
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                return dataVizBuilder(snapshot.data);
            }
            return null; // unreachable
          },
        );
  }

  dataVizBuilder(DocumentSnapshot snapshot) {
    return (
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
             /* Text(
                "Last Login time",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                DateFormat('dd MMM yyyy kk:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(snapshot['lastLogin']
                    )
                  )
                ),
                style: TextStyle(fontSize: 25.0, color: Colors.teal),
              ),*/
              Container(
                margin: EdgeInsets.only(top:0),
                child:_Animation()
              ),
              Container(
                  height: 200,
                  child: charts.PieChart(seriesList,
                      animate: animate,
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 100,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator()
                          ]
                      )
                  )
              ),
              Text(
                "Total time spent (May 2019)",
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
              /*  (new Duration(seconds: int.parse(snapshot['totalTimeSpent'])))
                    .inHours
                    .toString(),*/
                widget.hoursSpentToday.toStringAsPrecision(2) + ' minutes',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                )
              ),

              Container(
              margin: EdgeInsets.only(top:20),
              child:
                Text(
                  "Most contacted user",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              Text(
                snapshot['mostContacted'],
                style: TextStyle(fontSize: 15.0, color: Colors.grey),
              )
            ],
          ),


        ]
      )
    );
  }

  static List<charts.Series<Messages, String>> _createSampleData(
      DocumentSnapshot snapshot) {
    final sent = [
      new Messages(0, "Received", int.parse(snapshot['totalReceived'])),
      new Messages(1, "Sent", int.parse(snapshot['totalSent'])),
    ];

    return [
      new charts.Series<Messages, String>(
        id: 'Messages',
        domainFn: (Messages m, _) => m.type,
        measureFn: (Messages m, _) => m.total,
        data: sent,
        labelAccessorFn: (Messages row, _) => '${row.type}: ${row.total}',
        fillColorFn: (Messages, color) => charts.Color.fromHex(),
      )
    ];
  }

  Future<DocumentSnapshot> getData() async {
//    Map<String, String> map;
    DocumentSnapshot snapshot;
    final QuerySnapshot result =
    await Firestore.instance.collection('dv').getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 0) {
      Fluttertoast.showToast(msg: 'Nothing to Show');
    } else {
      snapshot = documents[0];
//      map = snapshot.data.map((key, val) {
//        return MapEntry(key, val.toString());
//      });
//      print(map);
    }
    seriesList = _createSampleData(snapshot);
    return snapshot;
  }

  Widget _Animation() {
    return Row( mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150.0,
            child: Center(child:
            ScaleAnimatedTextKit(
              onTap: () {},
              text: ["Messages Sent v/s","Messages Received"],
              textStyle:
              TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Canterbury"
              ),
            )
            ),
          )
        ]
    );
  }


}
