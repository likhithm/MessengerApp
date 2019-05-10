import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Connect/data_viz/screens/data_v_screen.dart';
import 'package:Connect/data_viz/screens/leaderboard_fragment.dart';



class MyTabView extends StatelessWidget {

  final String currentUserId;
  MyTabView(this.currentUserId);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color:Colors.lightBlue),
              actions: <Widget>[
                FlatButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                )
              ],
              title: Text("Dashboard",  style: TextStyle(color: Colors.lightBlue),),
              bottom: TabBar(
                indicatorColor: Colors.cyan,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.insert_chart,color: Colors.lightBlue,),
                    //text: 'Statistics',
                  ),
                  Tab(
                    icon: Icon(Icons.mood,color:Colors.lightBlue),
                    //text: "Favorites",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                DataViz(currentUserId),
               LeaderBoard(currentUserId),
              ],
            ),
          ),
        )
    );
  }
}
