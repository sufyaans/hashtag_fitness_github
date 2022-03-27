// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, library_prefixes
import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class PerformWorkout extends StatefulWidget {
  String workoutName = "";
  PerformWorkout({required this.workoutName, Key? key}) : super(key: key);
  @override
  _PerformWorkoutState createState() => _PerformWorkoutState();
}

class _PerformWorkoutState extends State<PerformWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          widget.workoutName,
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
        actions: [
          IconButton(
              icon: Icon(Icons.calendar_today),
              tooltip: 'Calendar',
              //color: Colors.black,
              onPressed: () => {
                    // View history of PerformWorkouts
                  }),
        ],
      ),
      body: PerformWorkoutPage(workoutName: widget.workoutName),
    );
  }
}

class PerformWorkoutPage extends StatefulWidget {
  String workoutName = "";
  PerformWorkoutPage({required this.workoutName, Key? key}) : super(key: key);
  @override
  _PerformWorkoutPageState createState() => _PerformWorkoutPageState();
}

class _PerformWorkoutPageState extends State<PerformWorkoutPage> {
  var workoutList = [];
  var stopwatch = Stopwatch();
  var _timer;
  final List<TextEditingController> _weightControllers = [];
  final List<TextEditingController> _repControllers = [];

  initState() {
    if (this.mounted) {
      getData();
    }
    stopwatch.start();
    if (this.mounted) {
      _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    }
  }

  finishWorkout() async {
    Map<String, List<String>> workouts = new Map<String, List<String>>();
    print(_weightControllers.length);
    for (var i = 0; i < workoutList.length; i++) {
      print(workoutList[i]);
      // workouts.putIfAbsent(workoutList[i], () => )
      workouts[workoutList[i]] = [
        _weightControllers[i].text,
        _repControllers[i].text
      ];
    }
    print(workouts);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Workouts')
        .add({'workouts': workouts});
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('WorkoutTemplates')
        .doc(widget.workoutName)
        .get()
        .then((value) {
      setState(() {
        workoutList = value.data()!['workoutList'];
      }); // Access your after your get the data
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 25),
              child: Text(
                formatTime(stopwatch.elapsedMilliseconds),
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 24,
                  color: vr.whiteColor,
                ),
              ),
            ),
            ListView.builder(
                itemCount: workoutList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  _weightControllers.add(new TextEditingController());
                  _repControllers.add(new TextEditingController());

                  return Padding(
                      padding: EdgeInsetsDirectional.only(top: 15),
                      child: ListTile(
                        // leading: Icon(Icons.list),
                        title: Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: Text(
                              workoutList[index],
                              style: TextStyle(
                                fontFamily: vr.basicFont,
                                fontSize: 18,
                                color: vr.orangeColor,
                              ),
                            )),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            SizedBox(
                                height: 50,
                                width: 100,
                                child: TextField(
                                  controller: _weightControllers[index],
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    labelText: 'Weight',
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                )),
                            SizedBox(
                                height: 50,
                                width: 100,
                                child: TextField(
                                  controller: _repControllers[index],
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    labelText: 'Reps',
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                      ));
                }),
            Padding(padding: EdgeInsetsDirectional.only(top: 20)),
            Bounceable(
              onTap: () async {
                await finishWorkout();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: vr.orangeColor,
                  elevation: 7,
                  child: Center(
                    child: Text(
                      'FINISH WORKOUT',
                      style: TextStyle(
                        color: vr.whiteColor,
                        fontFamily: vr.basicFont,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsetsDirectional.only(top: 20)),
            Bounceable(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: vr.orangeColor,
                  elevation: 7,
                  child: Center(
                    child: Text(
                      'CANCEL WORKOUT',
                      style: TextStyle(
                        color: vr.whiteColor,
                        fontFamily: vr.basicFont,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
