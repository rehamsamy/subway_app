import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subway_app/create_request.dart';
import 'package:subway_app/login.dart';
import 'package:subway_app/register.dart';
import 'package:subway_app/sender_receiver.dart';
import 'package:subway_app/services_api/services_api.dart';

import 'home.dart';
import 'models/dest_model.dart';

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      //  primarySwatch: Colors.white10,
        primaryColor: Colors.white,
        primaryColorDark: Colors.white
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
