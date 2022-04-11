// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hashtag_fitness/page/measurementCalendar.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => measurementCalendar()),
                );
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
  var date = DateTime.now();
  String time = "";
  static final DateFormat formatter = DateFormat('yyyy_MM_dd');

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    setState(() {
      time = formatter.format(date);
    });
  }

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

  TextEditingController bodyWeightCont = TextEditingController();
  TextEditingController bodyFatCont = TextEditingController();
  TextEditingController chestCont = TextEditingController();
  TextEditingController waistCont = TextEditingController();
  TextEditingController neckCont = TextEditingController();
  TextEditingController rightArmCont = TextEditingController();
  TextEditingController leftArmCont = TextEditingController();
  TextEditingController leftThighCont = TextEditingController();
  TextEditingController rightThighCont = TextEditingController();
  TextEditingController hipCont = TextEditingController();

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
  late FToast fToast;
  showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Measurements Saved!", style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  saveMeasurement() async {
    String uname = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uname)
        .collection("Measurements")
        .doc(time)
        .set({
      "timestamp": DateTime.now(),
      "Body Weight (KG)": int.parse(bodyWeightCont.text),
      "Body Fat (%)": int.parse(bodyFatCont.text),
      "Chest Measurement (CM)": int.parse(chestCont.text),
      "Waist Measurement (CM)": int.parse(waistCont.text),
      "Neck Measurement (CM)": int.parse(neckCont.text),
      "Right Arm Measurement (CM)": int.parse(rightArmCont.text),
      "Left Arm Measurement (CM)": int.parse(leftArmCont.text),
      "Right Thigh Measurement (CM)": int.parse(rightThighCont.text),
      "Left Thigh Measurement (CM)": int.parse(leftThighCont.text),
      "Hip Measurement (CM)": int.parse(hipCont.text),
    }).then((value) {
      bodyWeightCont.clear();
      bodyFatCont.clear();
      chestCont.clear();
      waistCont.clear();
      neckCont.clear();
      rightArmCont.clear();
      leftArmCont.clear();
      rightThighCont.clear();
      leftThighCont.clear();
      hipCont.clear();
    }).catchError((error) =>
            print("Failed to update measurement collection: $error"));
  }

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
            controller: bodyWeightCont,
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
            controller: bodyFatCont,
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
            controller: chestCont,
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
            controller: waistCont,
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
            controller: neckCont,
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
            controller: rightArmCont,
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
            controller: leftArmCont,
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
            controller: rightThighCont,
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
            controller: leftThighCont,
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
            controller: hipCont,
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
              showToast();
              saveMeasurement();
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
