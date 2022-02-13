import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'measurement.dart';
import 'package:hashtag_fitness/variables.dart' as vr;

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({Key? key}) : super(key: key);

  @override
  _LogMealScreenState createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          'Add a Meal',
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
      ),
      body: LogMeal(),
    );
  }
}

class LogMeal extends StatefulWidget {
  const LogMeal({Key? key}) : super(key: key);

  @override
  _LogMealState createState() => _LogMealState();
}

class _LogMealState extends State<LogMeal> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
