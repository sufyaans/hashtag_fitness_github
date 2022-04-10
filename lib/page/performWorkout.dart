// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, library_prefixes
import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hashtag_fitness/page/workoutCalendar.dart';
//import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class PerformWorkout extends StatefulWidget {
  String workoutName = "";
  PerformWorkout({required this.workoutName, Key? key}) : super(key: key);
  @override
  _PerformWorkoutState createState() => _PerformWorkoutState();
}

class _PerformWorkoutState extends State<PerformWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          widget.workoutName,
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
      ),
      body: PerformWorkoutPage(workoutName: widget.workoutName),
    );
  }
}

class PerformWorkoutPage extends StatefulWidget {
  String workoutName = "";
  PerformWorkoutPage({required this.workoutName, Key? key}) : super(key: key);
  @override
  _PerformWorkoutPageState createState() => _PerformWorkoutPageState();
}

class _PerformWorkoutPageState extends State<PerformWorkoutPage> {
  var workoutList = [];
  var sets = [];
  var stopwatch = Stopwatch();
  List<List<bool>> isChecked = [];
  ScrollController _controller = new ScrollController();
  var _timer;
  List<TextEditingController> _weightControllers = [];
  List<TextEditingController> _repControllers = [];

  initState() {
    if (this.mounted) {
      getData();
    }
    super.initState();
    fToast = FToast();
    fToast.init(context);
    stopwatch.start();
    if (this.mounted) {
      _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    }
  }

  late FToast fToast;

  _showToast() async {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: vr.orangeColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Workout Complete!"),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.TOP,
    );
  }

  finishWorkout() async {
    Map<String, List<String>> workouts = new Map<String, List<String>>();
    print(_weightControllers.length);
    for (var i = 0; i < workoutList.length; i++) {
      // print(workoutList[i]);
      // workouts.putIfAbsent(workoutList[i], () => )
      workouts[workoutList[i]] = [
        _weightControllers[i].text,
        _repControllers[i].text
      ];
    }
    // print(workouts);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Workouts')
        .add({
      'workouts': workouts,
      'timestamp': Timestamp.now(),
      'stopwatch': formatTime(stopwatch.elapsedMilliseconds)
    });
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('WorkoutTemplates')
        .doc(widget.workoutName)
        .get()
        .then((value) {
      setState(() {
        workoutList = value.data()!['workoutList'];
        sets = value.data()!['sets'];
        for (int i = 0; i < workoutList.length; i++) {
          List<bool> tmp = [];
          for (int j = 0; j < int.parse(sets[i]); j++) {
            tmp.add(false);
          }
          isChecked.add(tmp);
        }
      }); // Access your after your get the data
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 25),
              child: Text(
                formatTime(stopwatch.elapsedMilliseconds),
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 24,
                  color: vr.whiteColor,
                ),
              ),
            ),
            SingleChildScrollView(
              child: ListView.builder(
                  itemCount: workoutList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    _weightControllers.add(new TextEditingController());
                    _repControllers.add(new TextEditingController());
                    return Padding(
                      padding: EdgeInsetsDirectional.only(top: 15),
                      child: ListTile(
                        // leading: Icon(Icons.list),
                        title: Padding(
                          padding: EdgeInsetsDirectional.only(start: 10),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  workoutList[index],
                                  style: TextStyle(
                                    fontFamily: vr.basicFont,
                                    fontSize: 18,
                                    color: vr.orangeColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 40),
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Sets",
                                      style: TextStyle(
                                        fontFamily: vr.basicFont,
                                        fontSize: 18,
                                        color: vr.orangeColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Weight",
                                      style: TextStyle(
                                        fontFamily: vr.basicFont,
                                        fontSize: 18,
                                        color: vr.orangeColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Reps",
                                      style: TextStyle(
                                        fontFamily: vr.basicFont,
                                        fontSize: 18,
                                        color: vr.orangeColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Done?",
                                      style: TextStyle(
                                        fontFamily: vr.basicFont,
                                        fontSize: 18,
                                        color: vr.orangeColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: int.parse(sets[index]),
                                itemBuilder: (BuildContext context, int ind) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              100),
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                            alignment: Alignment.center,
                                            child: Text(
                                              (ind + 1).toString(),
                                              style: TextStyle(
                                                fontFamily: vr.basicFont,
                                                fontSize: 18,
                                                color: vr.orangeColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: ConstrainedBox(
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              20),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                ),
                                                validator: (String? value) {
                                                  if (value!.isEmpty)
                                                    return 'This field is required';
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  labelText: 'Weight',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      40),
                                              child: ConstrainedBox(
                                                constraints:
                                                    BoxConstraints.tightFor(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            20),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                  validator: (String? value) {
                                                    if (value!.isEmpty)
                                                      return 'This field is required';
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    labelText: 'Reps',
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Checkbox(
                                              checkColor: vr.whiteColor,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: isChecked[index][ind],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked[index][ind] =
                                                      value!;
                                                });
                                              }),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          // trailing: Wrap(
                          //   spacing: 12, // space between two icons
                          //   children: <Widget>[
                          //     SizedBox(
                          //         height: 50,
                          //         width: 100,
                          //         child: TextField(
                          //           controller: _weightControllers[index],
                          //           style: TextStyle(color: Colors.white),
                          //           decoration: InputDecoration(
                          //             focusedBorder: OutlineInputBorder(
                          //               borderSide:
                          //                   BorderSide(color: Colors.white),
                          //             ),
                          //             enabledBorder: OutlineInputBorder(
                          //               borderSide:
                          //                   BorderSide(color: Colors.white),
                          //             ),
                          //             labelText: 'Weight',
                          //             labelStyle: TextStyle(color: Colors.white),
                          //           ),
                          //         )),
                          //     SizedBox(
                          //         height: 50,
                          //         width: 100,
                          //         child: TextField(
                          //           controller: _repControllers[index],
                          //           style: TextStyle(color: Colors.white),
                          //           decoration: InputDecoration(
                          //             focusedBorder: OutlineInputBorder(
                          //               borderSide:
                          //                   BorderSide(color: Colors.white),
                          //             ),
                          //             enabledBorder: OutlineInputBorder(
                          //               borderSide:
                          //                   BorderSide(color: Colors.white),
                          //             ),
                          //             labelText: 'Reps',
                          //             labelStyle: TextStyle(color: Colors.white),
                          //           ),
                          //         )),
                          //   ],
                          // ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(padding: EdgeInsetsDirectional.only(top: 20)),
            Bounceable(
              onTap: () async {
                await finishWorkout();
                _showToast();

                // _weightControllers = [];
                // _repControllers = [];
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: vr.orangeColor,
                  elevation: 7,
                  child: Center(
                    child: Text(
                      'FINISH WORKOUT',
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
            Padding(padding: EdgeInsetsDirectional.only(top: 20)),
            Bounceable(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: vr.orangeColor,
                  elevation: 7,
                  child: Center(
                    child: Text(
                      'CANCEL WORKOUT',
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
      ),
    );
  }
}
