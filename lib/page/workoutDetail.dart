// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, library_prefixes, unnecessary_new, prefer_final_fields, unused_local_variable, await_only_futures, must_call_super, annotate_overrides, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:hashtag_fitness/page/performWorkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewWorkoutPage extends StatefulWidget {
  int i = 0;
  String name = "";
  String workoutName = "";
  final QueryDocumentSnapshot? workoutSearch;

  ViewWorkoutPage(
      {required this.i,
      required this.name,
      required this.workoutName,
      required this.workoutSearch});

  @override
  _ViewWorkoutPageState createState() => _ViewWorkoutPageState();
}

class _ViewWorkoutPageState extends State<ViewWorkoutPage> {
  var workouts = [];
  var workoutsName = [];
  initState() {
    getData();
  }

  CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('WorkoutTemplates');

  getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final workName = querySnapshot.docs.map((doc) => doc.id).toList();
    setState(() {
      workouts = allData;
      workouts = List.from(workouts.reversed);
      workoutsName = List.from(workName.reversed);
    });
  }

  deleteWorkout(String name) async {
    final collection = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('WorkoutTemplates');
    await collection.doc(name).delete();
    getData();
  }

  Widget build(BuildContext context) {
    return bottomSheet(widget.i, widget.name, widget.workoutName);
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: Navigator.of(context).pop,
        child: GestureDetector(onTap: () {}, child: child),
      );
  Widget bottomSheet(var i, var name, var workoutName) {
    return makeDismissible(
        child: DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.8,
      minChildSize: 0.2,
      builder: (BuildContext context, ScrollController scrollController) {
        int index = 0;
        return Container(
          decoration: BoxDecoration(
            color: vr.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
          ),
          padding: EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            controller: scrollController,
            children: [
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: vr.basicFont,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                  itemCount: widget.workoutSearch!['workoutList'].length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: Padding(
                          padding: EdgeInsetsDirectional.only(start: 10),
                          child: Text(
                            'Sets: ' + widget.workoutSearch!["sets"][index],
                            style: TextStyle(
                              fontFamily: vr.basicFont,
                              fontSize: 18,
                              color: vr.orangeColor,
                            ),
                          )),
                      title: Padding(
                          padding: EdgeInsetsDirectional.only(end: 10),
                          child: Text(
                            widget.workoutSearch!["workoutList"][index],
                            style: TextStyle(
                              fontFamily: vr.basicFont,
                              fontSize: 18,
                            ),
                          )),
                    );
                  }),
              SizedBox(height: 10),
              Bounceable(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context, widget.workoutName, i),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 40,
                  child: Material(
                    borderRadius: BorderRadius.circular(24),
                    color: vr.errorColor,
                    elevation: 7,
                    child: Center(
                      child: Text(
                        'DELETE WORKOUT',
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
              SizedBox(height: 10),
              Bounceable(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PerformWorkout(workoutName: workoutName, name: name),
                    ),
                  );
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
                        'START WORKOUT',
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
        );
      },
    ));
  }

  Widget _buildPopupDialog(BuildContext context, String name, int index) {
    return AlertDialog(
      title: Text(
        'Delete',
        style: TextStyle(
          color: vr.whiteColor,
        ),
      ),
      content: Text(
        'Are you sure you want to delete this workout',
        style: TextStyle(
          color: vr.whiteColor,
        ),
      ),
      backgroundColor: vr.backGround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        //Yes
        Bounceable(
          onTap: () {
            setState(() {
              deleteWorkout(name);
              for (int i = 0; i < workouts.length; i++) {
                if (workouts[i]["name"] == widget.workoutSearch!["name"]) {
                  workouts.remove(i);
                }
              }
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(24),
              color: vr.orangeColor,
              elevation: 7,
              child: Center(
                child: Text(
                  'Yes',
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
        SizedBox(
          height: 10,
        ),
        //NO
        Bounceable(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(24),
              color: vr.errorColor,
              elevation: 7,
              child: Center(
                child: Text(
                  'No',
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
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
