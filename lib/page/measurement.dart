// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/page/dashboard.dart';

import 'package:hashtag_fitness/variables.dart' as vr;

class Measurement extends StatefulWidget {
  @override
  _MeasurementState createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          'Measurement',
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
        actions: [
          IconButton(
              icon: Icon(Icons.calendar_today),
              tooltip: 'Calendar',
              //color: Colors.black,
              onPressed: () => {
                    // View history of meals
                  }),
        ],
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
  late String bodyWeight,
      bodyFat,
      chest,
      waist,
      neck,
      rightArm,
      leftArm,
      rightThigh,
      leftThigh,
      hip;

  //To check fields during submit
  // final formKey = new GlobalKey<FormState>();
  // checkFields() {
  //   final form = formKey.currentState;
  //   if (form!.validate()) {
  //     form.save();
  //     return true;
  //   }
  //   return false;
  // }

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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.bodyWeight = value;
            },
            //validator: (value) => value!.isEmpty ? 'Body Weight measurement is required' : null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.bodyFat = value;
            },
            //validator: (value) => value!.isEmpty ? 'Body Fat measurement is required' : null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.chest = value;
            },
            // validator: (value) => value!.isEmpty ? 'Chest measurement is required' : null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.waist = value;
            },
            //validator: (value) => value!.isEmpty ? 'Waist measurement is required' : null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.neck = value;
            },
            //validator: (value) => value!.isEmpty ? 'Neck measurement is required' : null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.rightArm = value;
            },
            //validator: (value) => value!.isEmpty ? 'Right Arm measurement is required' : null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.leftArm = value;
            },
            //validator: (value) => value!.isEmpty ? 'Left Arm measurement is required' : null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.rightThigh = value;
            },
            //validator: (value) => value!.isEmpty? 'Right Thigh measurement is required': null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.leftThigh = value;
            },
            // validator: (value) => value!.isEmpty ? 'Left Thigh measurement is required' : null
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
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.hip = value;
            },
            // validator: (value) => value!.isEmpty ? 'Hips measurement is required' : null
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
                color: vr.orangeColor,
                elevation: 7,
                child: Center(
                  child: Text(
                    'Save Measurement',
                    style: TextStyle(
                      color: vr.whiteColor,
                      fontFamily: vr.basicFont,
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
