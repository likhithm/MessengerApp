import 'package:flutter/material.dart';
import 'package:messenger_app/views/login.dart';
import 'package:messenger_app/routes/routes.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
//    theme: ThemeData(fontFamily: 'IndieFlower'),
    home: new Login(),
    routes: routes,
  ));
}