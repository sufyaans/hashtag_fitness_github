// ignore_for_file: file_names, prefer_const_constructors

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

      body: getExercise(),
    );
  }
  /*
  Widget getExercise() {
    var size = MediaQuery.of(context).size;

    int count = 0;
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16),
            // width: size.width,
            // height: size.height,

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
      ],
    );
  }
  */

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: Navigator.of(context).pop,
        child: GestureDetector(onTap: () {}, child: child),
      );

  Widget getExercise() => makeDismissible(
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, controller) => Container(
            // Top corners need to be rounded
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(16),
            child: ListView(
              // Distance between the name and the top of the ShowModalSheet need to be smaller
              children: [
                Text(
                  widget.exercise!['name'],
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Level: ' + widget.exercise!['level'],
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Equipment: ' + widget.exercise!['equipment'],
                  style: TextStyle(fontSize: 16),
                ),
                //Need to output array of instructions
                // Text(
                //   'Instructions: ' + widget.exercise!["instructions"][0],
                //   style: TextStyle(fontSize: 16),
                // ),
              ],
            ),
          ),
        ),
      );
}
