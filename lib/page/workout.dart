import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: Text('Workout'),
        backgroundColor: Color(0xFF03111C),
      ),
      body: Center(
        child: Text('Workout Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
