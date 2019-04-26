import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class AppUsageChart extends StatefulWidget {

  @override
  AppUsageChartState createState() => new AppUsageChartState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class AppUsageChartState extends State<AppUsageChart> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      new ClicksPerYear('January', 738, Colors.red),
      new ClicksPerYear('Febrauary', 1443, Colors.yellow),
      new ClicksPerYear('March', 234, Colors.green),
      new ClicksPerYear('April', 123, Colors.blue),
    ];

    var series = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           /* new Text(
              'App usage statistics',
            ),*/
           /* new Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),*/
            chartWidget,
          ],
     /* floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),*/
    );
  }

}