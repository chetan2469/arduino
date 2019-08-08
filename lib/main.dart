import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  bool value = false;

  final databaseReference = FirebaseDatabase.instance.reference();

  void getLED() {
    databaseReference.child('Prathamesh_LED_STATUS').once().then((DataSnapshot snapshot) {
      if (int.parse(snapshot.value) == 1) {
        setState(() {
          value = true;
          print(true);
        });
      } else {
        setState(() {
          value = false;
          print(true);
        });
      }
    });
  }

  void updateLED() {
    if (value) {
      databaseReference.update({'Prathamesh_LED_STATUS': 1});
    } else {
      databaseReference.update({'Prathamesh_LED_STATUS': 0});
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("AUTOMATION"),),
        body: Container(
          child: Center(
              child: Switch(
            value: value,
            onChanged: (bool val) {
              setState(() {
                value = val;
                updateLED();
              });
            },
          )),
        ),
      ),
    );
  }
}
