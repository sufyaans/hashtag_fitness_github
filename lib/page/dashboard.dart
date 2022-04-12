// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hashtag_fitness/page/createWorkout.dart';
import 'package:hashtag_fitness/page/logMeal.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'measurement.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import './charts.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Stream<QuerySnapshot> getName() {
    var firestore = FirebaseFirestore.instance;
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    Stream<QuerySnapshot<Map<String, dynamic>>> qn =
        firestore.collection("users").snapshots();
    // firestore
    //     .collection("users")
    //     .where("user_id", isEqualTo: uid)
    //     .snapshots();
    return qn;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getName(),
      builder: (context, snapshot) {
        return Scaffold(
            backgroundColor: vr.backGround,
            // appBar: AppBar(
            //   title: Text(
            //     'DASHBOARD',
            //     style: TextStyle(fontFamily: basicFont),
            //   ),
            //   backgroundColor: backGround,
            // ),
            body: snapshot.hasData
                ? Dashboard(context: context, snapshot: snapshot.data!)
                : SpinKitRing(color: vr.whiteColor, size: 50.0));
      },
    );
  }
}

class Dashboard extends StatefulWidget {
  final BuildContext context;
  final QuerySnapshot snapshot;

  Dashboard({Key? key, required this.context, required this.snapshot})
      : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String uname = "";
  String dropdownValue = 'Chest Measurement (CM)';
  String timeRange = 'by Month';
  String timeRange2 = 'By Month';
  String Nutrition = "Carbs (g)";
  var chartValues = [];
  var nutritions = [];
  getUID() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      setState(() {
        uname = documentSnapshot['name'];
        print(uname);
        //print(documentSnapshot.data());
      });
    });
  }

  Future<void> getMeasurements() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Measurements')
        .get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var i in allData) {
      setState(() {
        chartValues.add([
          (i as Map<String, dynamic>)['timestamp'],
          (i as Map<String, dynamic>)[dropdownValue]
        ]);
      });
    }
  }

  Future<void> getNutrients() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Nutrition')
        .get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var i in allData) {
      setState(() {
        nutritions.add([
          (i as Map<String, dynamic>)['timestamp'],
          (i as Map<String, dynamic>)[Nutrition]
        ]);
      });
    }
  }

  initState() {
    getUID();
    getMeasurements();
    getNutrients();
  }

  // final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    // print(chartValues);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Welcome and login
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          Text(
                            "Hello  " + uname,
                            style: TextStyle(
                              color: vr.whiteColor,
                              fontSize: 30,
                              fontFamily: vr.basicFont,
                              fontWeight: FontWeight.w900,
                            ),
                          ), //Hello + user's name/email address
                        ],
                      ),
                      //Log out
                      IconButton(
                        onPressed: () async {
                          //FirebaseAuth.instance.signOut();
                          //Navigator.of(context).pop();

                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop;
                        },
                        icon: Icon(Icons.logout),
                        tooltip: 'Log out',
                        color: vr.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Submenu navigation
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shortcuts',
                          style: TextStyle(
                            fontSize: 20,
                            color: vr.whiteColor,
                            fontFamily: vr.basicFont,
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          createWorkout(),
                          logMeal(),
                          logMeasurement(),
                          findGym(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 11 * 5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 20,
                            color: vr.whiteColor,
                            fontFamily: vr.basicFont,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 25),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              enableFeedback: true,
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: vr.backGround,
                              style: TextStyle(
                                fontFamily: vr.basicFont,
                                fontSize: 15,
                              ),
                              underline: Container(
                                height: 2,
                                color: vr.orangeColor,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  chartValues = [];
                                  dropdownValue = newValue!;
                                  getMeasurements();
                                });
                              },
                              items: <String>[
                                'Chest Measurement (CM)',
                                'Hip Measurement (CM)',
                                'Left Arm Measurement (CM)',
                                'Right Arm Measurement (CM)',
                                'Left Thigh Measurement (CM)',
                                'Right Thigh Measurement (CM)',
                                'Neck Measurement (CM)',
                                'Waist Measurement (CM)',
                                'Body Fat (%)',
                                'Body Weight (KG)'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 25),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: DropdownButton<String>(
                              value: timeRange,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              enableFeedback: true,
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: vr.backGround,
                              style: TextStyle(
                                fontFamily: vr.basicFont,
                                fontSize: 15,
                              ),
                              underline: Container(
                                height: 2,
                                color: vr.orangeColor,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  timeRange = newValue!;
                                });
                              },
                              items: <String>[
                                'by Month',
                                'by Year',
                                // 'by Week',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsetsDirectional.only(top: 20)),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    Container(
                      height: MediaQuery.of(context).size.height / 11 * 3,
                      width: 500,
                      child: PointsLineChart.withSampleData(
                          chartValues, timeRange),
                    ),
                    // ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 25),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: DropdownButton<String>(
                      value: Nutrition,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      enableFeedback: true,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: vr.backGround,
                      style: TextStyle(
                        fontFamily: vr.basicFont,
                        fontSize: 15,
                      ),
                      underline: Container(
                        height: 2,
                        color: vr.orangeColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          nutritions = [];
                          Nutrition = newValue!;
                          getNutrients();
                        });
                      },
                      items: <String>[
                        'Carbs (g)',
                        'Fat (g)',
                        'Protein (g)',
                        'Total Calories (Kcal)',
                        'Total',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 25),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: DropdownButton<String>(
                      value: timeRange2,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      enableFeedback: true,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: vr.backGround,
                      style: TextStyle(
                        fontFamily: vr.basicFont,
                        fontSize: 15,
                      ),
                      underline: Container(
                        height: 2,
                        color: vr.orangeColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            timeRange2 = newValue!;
                          },
                        );
                      },
                      items: <String>[
                        'by Day',
                        // 'by Week',
                        // 'by Month',
                        'By Month',
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsetsDirectional.only(top: 20)),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            Container(
              height: MediaQuery.of(context).size.height / 11 * 3,
              width: 500,
              child: PointsLineChart.withSampleData(nutritions, timeRange2),
            ),
          ],
        ),
      ),
    );
  }
}

// Create a workout
class createWorkout extends StatelessWidget {
  const createWorkout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateWorkoutScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: Container(
          height: 80,
          width: 140,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: vr.whiteColor, //Change colour later on
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  // Text(
                  //   "Create a workout",
                  //   style: TextStyle(
                  //     fontFamily: basicFont,
                  //     fontSize: 15,
                  //   ),
                  // ),
                ],
              ),
              Text(
                "Create a workout",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Log a meal
class logMeal extends StatelessWidget {
  const logMeal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        //Navigate to log a meal
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LogMealScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: Container(
          height: 80,
          width: 140,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: vr.whiteColor, //Change colour later on
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.restaurant,
                  ), //Add workout image
                  SizedBox(width: 10),
                  // Text(
                  //   "Create a workout",
                  //   style: TextStyle(
                  //     fontFamily: basicFont,
                  //     fontSize: 15,
                  //   ),
                  // ),
                ],
              ),
              Text(
                "Log a meal",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Log a Measurement
class logMeasurement extends StatelessWidget {
  const logMeasurement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Measurement(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: Container(
          height: 80,
          width: 140,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: vr.whiteColor, //Change colour later on
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.straighten,
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Text(
                "Log a Measurement",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Find gym
class findGym extends StatefulWidget {
  const findGym({Key? key}) : super(key: key);

  @override
  State<findGym> createState() => _findGymState();
}

class _findGymState extends State<findGym> {
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => Measurement(),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: Container(
          height: 80,
          width: 140,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: vr.whiteColor, //Change colour later on
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.fitness_center_rounded,
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Text(
                "Find Gym Near Me",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
