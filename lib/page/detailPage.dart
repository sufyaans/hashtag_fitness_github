// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final QueryDocumentSnapshot? exercise;

  DetailPage({this.exercise});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Color(0xFF03111C),
      // appBar: AppBar(
      //   title: Text(widget.exercise!["name"]),
      //   backgroundColor: Color(0xFF03111C),
      // ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    int count = 0;
    return SingleChildScrollView(
      child: Stack(children: <Widget>[
        Container(
            width: size.width,
            height: size.height,

            // Exercise name should be output in large (Similar to appbar)
            // --- Following below should have labels saying what they are e.g. Level: Beginner
            // Category should be output
            // Equipment should be output
            // Level should be output
            // Instructions should be output (Instructions are set as an array)

            child: Text(
              ' Name: ' +
                  widget.exercise!["name"] +
                  '\n' +
                  ' Exercise level: ' +
                  widget.exercise!["level"] +
                  '\n' +
                  ' Equipment: ' +
                  widget.exercise!["equipment"] +
                  '\n' +
                  ' Muscle worked: ' +
                  widget.exercise!["primaryMuscles"][0],
              style: TextStyle(fontSize: 18, color: Colors.black, height: 1.5),
            )),
      ]),
    );
  }
}
