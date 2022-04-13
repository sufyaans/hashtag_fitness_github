// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/page/createWorkout.dart';
import 'package:hashtag_fitness/page/workoutCalendar.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:hashtag_fitness/page/performWorkout.dart';

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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => workoutCalendar(),
                      ),
                    ),
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
      workouts = List.from(workouts.reversed);
    });
  }

  deleteWorkout(String name) async {
    final collection = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('WorkoutTemplates');
    await collection
        .doc(name)
        .delete()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
    getData();
  }

  bottomSheet(var i, var name) {
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
            initialChildSize: 0.7,
            maxChildSize: 0.8,
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
                  controller: scrollController,
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
                                  'Sets: ' + workouts[i]["sets"][index],
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
                    SizedBox(height: 10),
                    Bounceable(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(
                              context, workouts[i]['name'], i),
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
                                PerformWorkout(workoutName: name),
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

  ScrollController _controller = new ScrollController();

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
            SizedBox(height: 20),
            SingleChildScrollView(
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  controller: _controller,
                  shrinkWrap: true,
                  itemCount: workouts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      // child: Bounceable(
                      //   onTap: () {
                      //     bottomSheet(index, workouts[index]["name"]);
                      //   },
                      child: ListTile(
                        leading: Icon(Icons.list),
                        tileColor: const Color(0xFFF4F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        // trailing: Text(
                        //   workouts[index]["name"],
                        //   style: TextStyle(
                        //     fontFamily: vr.basicFont,
                        //     fontSize: 18,
                        //     color: vr.whiteColor,
                        //   ),
                        // ),
                        title: Text(
                          workouts[index]["name"],
                          style: TextStyle(
                            fontFamily: vr.basicFont,
                            fontSize: 18,
                            //color: vr.black,
                          ),
                        ),
                        onTap: () {
                          bottomSheet(index, workouts[index]["name"]);
                        },
                      ),
                      // ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, String name, int index) {
    return AlertDialog(
      title: Text(
        'Delete',
        style: TextStyle(
          color: vr.whiteColor,
          //fontFamily: vr.basicFont,
        ),
      ),
      content: Text(
        'Are you sure you want to delete this workout',
        style: TextStyle(
          color: vr.whiteColor,
          //fontFamily: vr.basicFont,
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
              workouts.remove(workouts[index]);
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
