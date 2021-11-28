import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('Exercise Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}

class listPage extends StatefulWidget {
  @override
  _listPageState createState() => _listPageState();
}

class _listPageState extends State<listPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
