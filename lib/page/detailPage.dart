// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

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
    return getExercise();
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

  Widget getExercise() {
    //ModalBottomSheet takes up the whole page rather than 90% of it for 50% of it
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (BuildContext context, ScrollController scrollController) {
          int index = 0;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
            ),
            padding: EdgeInsets.all(16.0),
            child: ListView(
              controller: scrollController,
              // Distance between the name and the top of the ShowModalSheet need to be smaller
              children: [
                Center(
                  child: Text(
                    widget.exercise!['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10.0,
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
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Instructions: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                ...widget.exercise!["instructions"]
                    .map((title) => Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${++index}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(child: Text(title)),
                              ],
                            ),
                            SizedBox(height: 8.0),
                          ],
                        ))
                    .toList()
              ],
            ),
          );
        },
      ),
    );
  }
}
