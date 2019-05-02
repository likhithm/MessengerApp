import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Connect/const.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



class LeaderBoard extends StatefulWidget {
  final String currentUserId;

  LeaderBoard(this.currentUserId);

  @override
  State createState() =>  LeaderBoardState(currentUserId: currentUserId);
}

class  LeaderBoardState extends State< LeaderBoard> {
  LeaderBoardState({Key key, @required this.currentUserId});

  final String currentUserId;

  bool isLoading = false;


  Widget buildItem(BuildContext context, DocumentSnapshot document,int index) {
    if (document['id'] == currentUserId) {
      return highlightWidget(document,index);
    } else {
      double score = 100/index;
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  index.toString(),
                  style: TextStyle(color: Colors.black54),
                ),
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
              ),
              Material(
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                        ),
                        width: 50.0,
                        height: 50.0,
                        padding: EdgeInsets.all(15.0),
                      ),
                  imageUrl: document['photoUrl'],
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${document['nickname']}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                    ],
                  ),
                ),
              ),
              //_Animation(),
              Container(
                child: Text(
                  score.toStringAsFixed(2),
                  style: TextStyle(color: Colors.black54),
                ),
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              ),
              Container(
                child: Icon(Icons.mood,color:Colors.cyan),
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              ),
            ],
          ),
          // color: greyColor2,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: greyColor2, width: 0.5)),
            color: Colors.white),
      );
    }
  }

  Widget highlightWidget(DocumentSnapshot document,int index){
    double score = 100/index;
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                index.toString(),
                style: TextStyle(color: Colors.white),
              ),
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
            ),
            Material(
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                      width: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(15.0),
                    ),
                imageUrl: document['photoUrl'],
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              clipBehavior: Clip.hardEdge,
            ),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${document['nickname']}',
                        style: TextStyle(color: Colors.white),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text(
                score.toStringAsFixed(2),
                style: TextStyle(color: Colors.white),
              ),
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            ),
            Container(
              child: Icon(Icons.mood,color:Colors.yellowAccent),
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            ),
          ],
        ),
        // color: greyColor2,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      decoration: new BoxDecoration(
          border: new Border(
              bottom: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.cyan),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //WillPopScope(
      //child:
      Stack(
        children: <Widget>[
          Container(
            child: StreamBuilder(
              stream: Firestore.instance.collection('users').orderBy('rank',descending: false).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    ),
                  );
                } else {
                  return ListView.builder(
                    //padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(context, snapshot.data.documents[index],index+1),
                    itemCount: snapshot.data.documents.length,
                  );
                }
              },
            ),
          ),

          // Loading
          Positioned(
            child: isLoading
                ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
                : Container(),
          )
        ],
      ),
      //onWillPop: onBackPress,
      //),
    );
  }

  Widget _Animation(){
    return ScaleAnimatedTextKit(
              onTap: () {},
              text: ["Happiness","Score"],
              textStyle:
              TextStyle(
                  //fontSize: 15.0,
                  fontFamily: "Canterbury",
                  color:Colors.yellow
              ),
    );
  }

}


