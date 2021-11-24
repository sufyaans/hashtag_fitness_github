import 'package:flutter/material.dart';

class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise')),
      body: Center(
        child: Text('Exercise Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
