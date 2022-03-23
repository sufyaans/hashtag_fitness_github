// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/page/createWorkout.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          'Workout',
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
        actions: [
          IconButton(
              icon: Icon(Icons.calendar_today),
              tooltip: 'Calendar',
              //color: Colors.black,
              onPressed: () => {
                    // View history of workouts
                  }),
        ],
      ),
      body: WorkoutPage(),
    );
  }
}

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  var workouts = [];
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
    setState(() {
      workouts = allData;
    });
    print(allData);
  }

  bottomSheet(var i) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: Navigator.of(context).pop,
          child: GestureDetector(onTap: () {}, child: child),
        );

    //Need to fix the scroll behaviour
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: makeDismissible(
          child: DraggableScrollableSheet(
            initialChildSize: 0.9,
            maxChildSize: 0.9,
            minChildSize: 0.2,
            builder: (BuildContext context, ScrollController scrollController) {
              int index = 0;
              return Container(
                decoration: BoxDecoration(
                  color: vr.whiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(18.0)),
                ),
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                        itemCount: workouts[i]['workoutList'].length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            // leading: Icon(Icons.list),
                            trailing: Padding(
                                padding: EdgeInsetsDirectional.only(start: 10),
                                child: Text(
                                  workouts[i]["sets"][index],
                                  style: TextStyle(
                                    fontFamily: vr.basicFont,
                                    fontSize: 18,
                                    color: vr.orangeColor,
                                  ),
                                )),
                            title: Padding(
                                padding: EdgeInsetsDirectional.only(end: 10),
                                child: Text(
                                  workouts[i]["workoutList"][index],
                                  style: TextStyle(
                                    fontFamily: vr.basicFont,
                                    fontSize: 18,
                                    //color: vr.whiteColor,
                                  ),
                                )),
                          );
                        }),
                    Bounceable(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateWorkoutScreen(),
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
          ),
        ),
      ),
    );
  }

/*
  _showDialog(var i) {
    slideDialog.showSlideDialog(
      context: context,
      child: ListView(
        shrinkWrap: true,
        children: [
          ListView.builder(
              itemCount: workouts[i]['workoutList'].length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  // leading: Icon(Icons.list),
                  trailing: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Text(
                        workouts[i]["sets"][index],
                        style: TextStyle(
                          fontFamily: vr.basicFont,
                          fontSize: 18,
                          color: vr.orangeColor,
                        ),
                      )),
                  title: Padding(
                      padding: EdgeInsetsDirectional.only(end: 10),
                      child: Text(
                        workouts[i]["workoutList"][index],
                        style: TextStyle(
                          fontFamily: vr.basicFont,
                          fontSize: 18,
                          color: vr.whiteColor,
                        ),
                      )),
                );
              }),
          Bounceable(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateWorkoutScreen(),
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
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.white,
      backgroundColor: Colors.black,
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            Bounceable(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateWorkoutScreen(),
                  ),
                );
              },
              child: Container(
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: vr.orangeColor,
                  elevation: 7,
                  child: Center(
                    child: Text(
                      'CREATE A WORKOUT TEMPLATE',
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
            SizedBox(height: 20),
            Text(
              "Saved Workouts",
              style: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: vr.whiteColor,
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: workouts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Bounceable(
                      onTap: () {
                        bottomSheet(index);
                      },
                      child: ListTile(
                          leading: Icon(Icons.list, color: Colors.white),
                          // trailing: Text(
                          //   workouts[index]["name"],
                          //   style: TextStyle(
                          //     fontFamily: vr.basicFont,
                          //     fontSize: 18,
                          //     color: vr.whiteColor,
                          //   ),
                          // ),
                          title: Text(workouts[index]["name"],
                              style: TextStyle(
                                fontFamily: vr.basicFont,
                                fontSize: 18,
                                color: vr.whiteColor,
                              ))));
                }),
          ],
        ),
      ),
    );
  }
}
