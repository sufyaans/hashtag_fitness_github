// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hashtag_fitness/variables.dart' as vr;

class AddExercise extends StatefulWidget {
  const AddExercise({Key? key}) : super(key: key);

  @override
  _AddExerciseState createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          'Add Exercise',
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
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
  // var date = DateTime.now();
  // String time = "";

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
  }

  late String exerciseName,
      exerciseLevel,
      exerciseEquipment,
      exerciseInstructions;

  TextEditingController exerciseNameCont = TextEditingController();
  TextEditingController exerciseLevelCont = TextEditingController();
  TextEditingController exerciseEquipmentCont = TextEditingController();
  TextEditingController exerciseInstructionsCont = TextEditingController();

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
          Text("Exercise Saved!", style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  saveExercise() async {
    await FirebaseFirestore.instance.collection("exercises").add({
      "name": exerciseNameCont.text,
      "level": exerciseLevelCont.text,
      "equipment": exerciseEquipmentCont.text,
      "instructions": exerciseInstructionsCont.text,
    }).then((value) {
      exerciseNameCont.clear();
      exerciseLevelCont.clear();
      exerciseEquipmentCont.clear();
      exerciseInstructionsCont.clear();
    }).catchError(
        (error) => print("Failed to update exercise collection: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          //equipment
          SizedBox(height: 25),
          TextFormField(
            controller: exerciseNameCont,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Name',
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
              this.exerciseName = value;
            },
            //validator: (value) => value!.isEmpty ? 'Equipment is required' : null
          ),

          //exerciseLevel
          SizedBox(height: 25),
          TextFormField(
            controller: exerciseLevelCont,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Level',
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
              this.exerciseLevel = value;
            },
            //validator: (value) => value!.isEmpty ? 'Level is required' : null
          ),

          //equipment
          SizedBox(height: 25),
          TextFormField(
            controller: exerciseEquipmentCont,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Equipment',
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
              this.exerciseEquipment = value;
            },
            //validator: (value) => value!.isEmpty ? 'Equipment is required' : null
          ),

          //Instructions
          SizedBox(height: 25),
          TextFormField(
            controller: exerciseInstructionsCont,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Instructions',
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
              this.exerciseInstructions = value;
            },
            //validator: (value) => value!.isEmpty ? 'Instructions is required' : null
          ),

          //Add exercise
          SizedBox(height: 50),
          Bounceable(
            onTap: () {
              //Add exercise
              showToast();
              saveExercise();
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
                    'Add Exercise',
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
        ],
      ),
    );
  }
}