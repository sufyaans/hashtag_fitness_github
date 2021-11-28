import 'package:flutter/material.dart';

class Nutrition extends StatefulWidget {
  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('Nutrition Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
