import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:Connect/data_viz/widgets/app_usage.dart';



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
    getUsageStats();

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
      body: AppUsageChart()
    );
  }

  void getUsageStats() async {
    // Initialization
    AppUsage appUsage = new AppUsage();
    try {
      // Define a time interval
      DateTime endDate = new DateTime.now();
      print(endDate);
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day, 0 , 0 , 0);
      print(startDate);

      // Fetch the usage stats
      Map<String, double> usage = await appUsage.fetchUsage(startDate, endDate);

      // (Optional) Remove entries for apps with 0 usage time
      usage.removeWhere((key,val) => val == 0);


      print(usage['com.messenger.app']);
    }
    on AppUsageException catch (exception) {
      print(exception);
    }
  }
}
