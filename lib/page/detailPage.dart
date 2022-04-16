// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hashtag_fitness/variables.dart' as vr;

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

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: Navigator.of(context).pop,
        child: GestureDetector(onTap: () {}, child: child),
      );

  Widget getExercise() {
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (BuildContext context, ScrollController scrollController) {
          int index = 0;
          return Container(
            decoration: BoxDecoration(
              color: vr.whiteColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
            ),
            padding: EdgeInsets.all(16.0),
            child: ListView(
              controller: scrollController,
              children: [
                Center(
                  child: Text(
                    widget.exercise!['name'],
                    style: TextStyle(
                      fontFamily: vr.basicFont,
                      fontSize: 24,
                    ),
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
