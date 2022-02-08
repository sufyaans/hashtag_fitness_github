// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:flutter/material.dart';

Color orangeColor = Colors.deepOrange;
Color backGround = Color(0xFF03111C);
String basicFont = 'roughMotion';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: AppBar(
        title: Text(
          'Create a workout',
          style: TextStyle(fontFamily: basicFont),
        ),
        backgroundColor: backGround,
      ),
      body: createWorkout(),
    );
  }
}

class createWorkout extends StatefulWidget {
  const createWorkout({Key? key}) : super(key: key);

  @override
  _createWorkoutState createState() => _createWorkoutState();
}

class _createWorkoutState extends State<createWorkout> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
