// ignore_for_file: prefer_const_constructors, camel_case_types, file_names
import 'package:flutter/material.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class workoutInfoScreen extends StatefulWidget {
  String exercise = "";
  var category;
  var equipment;
  var force;
  var instructions;
  var level;
  var mechanic;
  var primaryMuscle;
  var secondaryMuscle;
  workoutInfoScreen(
      {required this.exercise,
      required this.category,
      required this.equipment,
      required this.force,
      required this.instructions,
      required this.level,
      required this.mechanic,
      required this.primaryMuscle,
      required this.secondaryMuscle,
      Key? key})
      : super(key: key);
  @override
  _workoutInfoScreenState createState() => _workoutInfoScreenState();
}

class _workoutInfoScreenState extends State<workoutInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          widget.exercise,
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
      ),
      body: workoutInfo(
          exercise: widget.exercise,
          category: widget.category,
          equipment: widget.equipment,
          force: widget.force,
          instructions: widget.instructions,
          level: widget.level,
          mechanic: widget.mechanic,
          primaryMuscle: widget.primaryMuscle,
          secondaryMuscle: widget.secondaryMuscle),
    );
  }
}

class workoutInfo extends StatefulWidget {
  var exercise = "";
  var category;
  var equipment;
  var force;
  var instructions;
  var level;
  var mechanic;
  var primaryMuscle;
  var secondaryMuscle;
  workoutInfo(
      {required this.exercise,
      required this.category,
      required this.equipment,
      required this.force,
      required this.instructions,
      required this.level,
      required this.mechanic,
      required this.primaryMuscle,
      required this.secondaryMuscle,
      Key? key})
      : super(key: key);

  @override
  _workoutInfoState createState() => _workoutInfoState();
}

class _workoutInfoState extends State<workoutInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text("Basic Information",
                    style: TextStyle(
                        color: vr.whiteColor,
                        fontSize: 20,
                        fontFamily: vr.basicFont)),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Category: " + widget.category,
                              style: TextStyle(
                                  color: vr.whiteColor,
                                  fontSize: 14,
                                  fontFamily: vr.basicFont))),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Force: " + widget.force,
                              style: TextStyle(
                                  color: vr.whiteColor,
                                  fontSize: 14,
                                  fontFamily: vr.basicFont))),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Equipment: " + widget.equipment,
                              style: TextStyle(
                                  color: vr.whiteColor,
                                  fontSize: 14,
                                  fontFamily: vr.basicFont))),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Mechanic: " + widget.mechanic,
                              style: TextStyle(
                                  color: vr.whiteColor,
                                  fontSize: 14,
                                  fontFamily: vr.basicFont))),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Difficulty: " + widget.level,
                              style: TextStyle(
                                  color: vr.whiteColor,
                                  fontSize: 14,
                                  fontFamily: vr.basicFont))),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                Text("Instructions: " + widget.exercise,
                    style: TextStyle(
                        color: vr.whiteColor,
                        fontSize: 20,
                        fontFamily: vr.basicFont)),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 5 * 4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.instructions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                  (index + 1).toString() +
                                      ". " +
                                      widget.instructions[index],
                                  style: TextStyle(
                                      color: vr.whiteColor,
                                      fontSize: 14,
                                      fontFamily: vr.basicFont)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
