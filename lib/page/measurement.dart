import 'package:flutter/material.dart';

class Measurement extends StatefulWidget {
  const Measurement({Key? key}) : super(key: key);

  @override
  _MeasurementState createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
  String basicFont = 'Trueno';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: Text(
          'Measurement',
          style: TextStyle(fontFamily: basicFont),
        ),
        backgroundColor: Color(0xFF03111C),
      ),
      body: Center(
        child: Text('Measurement Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
