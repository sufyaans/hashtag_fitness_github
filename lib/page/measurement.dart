import 'package:flutter/material.dart';

class Measurement extends StatefulWidget {
  const Measurement({Key? key}) : super(key: key);

  @override
  _MeasurementState createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: Text('Measurement'),
        backgroundColor: Color(0xFF03111C),
      ),
      body: Center(
        child: Text('Measurement Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
