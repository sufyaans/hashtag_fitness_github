import 'package:flutter/material.dart';
import 'measurement.dart';

class Progress extends StatefulWidget {
  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: Text('Progress'),
        backgroundColor: Color(0xFF03111C),
        actions: [
          IconButton(
            icon: Icon(Icons.straighten),
            tooltip: 'Measure',
            //color: Colors.black,
            onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Measurement(),
                ),
              ),
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Progress Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
