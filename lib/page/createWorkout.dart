// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:hashtag_fitness/variables.dart' as vr;

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          'Create a workout',
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
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
