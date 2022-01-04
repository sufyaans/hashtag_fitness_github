import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hashtag_fitness/page/settings.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';

class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  String basicFont = 'roughMotion';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: Text(
          'Workout',
          style: TextStyle(fontFamily: basicFont),
        ),
        backgroundColor: Color(0xFF03111C),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              //color: Colors.black,
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Settings(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
