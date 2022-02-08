// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class Measurement extends StatefulWidget {
  @override
  _MeasurementState createState() => _MeasurementState();
}

Color orangeColor = Colors.deepOrange;
Color backGround = Color(0xFF03111C);
String basicFont = 'roughMotion';

class _MeasurementState extends State<Measurement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: AppBar(
        title: Text(
          'Measurement',
          style: TextStyle(fontFamily: basicFont),
        ),
        backgroundColor: backGround,
      ),
      body: MeasurementLog(),
    );
  }
}

class MeasurementLog extends StatefulWidget {
  const MeasurementLog({Key? key}) : super(key: key);

  @override
  _MeasurementLogState createState() => _MeasurementLogState();
}

class _MeasurementLogState extends State<MeasurementLog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.only(left: 25, right: 25),
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          //Body Weight Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Body Weight (kg)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Body Fat Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Body Fat (%)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Chest Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Chest Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Waist Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Waist Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Neck Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Neck Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Right Arm Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Right Arm Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Left Arm Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Left Arm Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Right Thigh Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Chest Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Left Thigh Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Left Thigh Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Right Thigh Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Right Thigh Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Hips Measurement
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Hip Measurement (cm)',
              labelStyle: TextStyle(
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: orangeColor),
              ),
            ),
            onChanged: (value) {
              //
            },
          ),

          //Save Measurement values
          SizedBox(height: 50),
          Bounceable(
            onTap: () {
              //Save measurement
            },
            child: Container(
              height: 40,
              child: Material(
                borderRadius: BorderRadius.circular(25),
                //shadowColor: Colors.orangeAccent,
                color: orangeColor,
                elevation: 7,
                child: Center(
                  child: Text(
                    'Save Measurement',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: basicFont,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
