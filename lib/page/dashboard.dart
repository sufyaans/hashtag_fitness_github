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

class Dashboard extends StatelessWidget {
  final BuildContext context;
  final QuerySnapshot snapshot;
  const Dashboard({Key? key, required this.context, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          "Hello  " + snapshot.docs[0]['name'],
                          style: TextStyle(
                            color: vr.whiteColor,
                            fontSize: 30,
                            fontFamily: vr.basicFont,
                            fontWeight: FontWeight.w900,
                          ),
                        ), //Hello + user's name/email address
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        //FirebaseAuth.instance.signOut();
                        //Navigator.of(context).pop();

                        AuthService().signOut();
                        Navigator.of(context).pop;
                      },
                      icon: Icon(Icons.logout),
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
              height: 130,
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
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,

                  // ),
                ],
              ),
            ),
          ),
        ],
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
