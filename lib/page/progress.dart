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
      appBar: AppBar(
        title: Text('Progress'),
        actions: [
          IconButton(
            icon: Icon(Icons.straighten),
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
