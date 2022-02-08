import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'measurement.dart';

Color orangeColor = Colors.deepOrange;
Color backGround = Color(0xFF03111C);
String basicFont = 'roughMotion';

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({Key? key}) : super(key: key);

  @override
  _LogMealScreenState createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: AppBar(
        title: Text(
          'Add a Meal',
          style: TextStyle(fontFamily: basicFont),
        ),
        backgroundColor: backGround,
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
