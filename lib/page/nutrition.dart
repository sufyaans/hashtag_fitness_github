import 'package:flutter/material.dart';

class Nutrition extends StatefulWidget {
  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  String basicFont = 'Trueno';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: Text(
          'Nutrition',
          style: TextStyle(fontFamily: basicFont),
        ),
        backgroundColor: Color(0xFF03111C),
      ),
      body: Center(
        child: Text('Nutrition Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
