// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hashtag_fitness/page/workoutInfo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          'Create a workout',
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
      ),
      body: createWorkout(),
    );
  }
}

class createWorkout extends StatefulWidget {
  const createWorkout({Key? key}) : super(key: key);

  @override
  _createWorkoutState createState() => _createWorkoutState();
}

class _createWorkoutState extends State<createWorkout> {
  TextEditingController workoutName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  ScrollController _controller = new ScrollController(); //New
  final List<TextEditingController> _controllers = [];
  var exercises = [];
  var chosen = [];
  var sets = [];
  bool proceed = true;

  void initState() {
    getExercise();
    fToast = FToast();
    fToast.init(context);
  }

  getExercise() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('exercises').get();
    final allData = await querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var i in allData) {
      setState(() {
        exercises.add(i);
      });
    }
  }

  late FToast fToast;
  showNameToast() {
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
          Text("Please enter a workout name",
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  showSetToast() {
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
          Text("Please enter all sets", style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  delete(var variable) async {
    await chosen.remove(variable);
  }

  saveWorkout() async {
    for (int i = 0; i < _controllers.length; i++) {
      sets.add(_controllers[i].text);
    }
    String uname = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uname)
        .collection("WorkoutTemplates")
        .doc(workoutName.text)
        .set({
      "timestamp": DateTime.now(),
      "name": workoutName.text,
      "workoutList": chosen,
      "sets": sets,
    }).then((value) {
      workoutName.clear();
    }).catchError((error) =>
            print("Failed to update workout template collection: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: workoutName,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'This field is required';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Workout Name',
                        labelStyle: TextStyle(
                          fontFamily: vr.basicFont,
                          fontSize: 24,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: vr.orangeColor),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  //New
                  // child: Container(

                  child: ListView.builder(
                    physics: ScrollPhysics(), //New
                    controller: _controller, //New
                    shrinkWrap: true,
                    itemCount: (chosen.length != 0) ? chosen.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      _controllers.add(new TextEditingController());
                      return ListTile(
                        title: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 10 * 9,
                              decoration: BoxDecoration(
                                  color: vr.backGround,
                                  border: Border.all(
                                      color: vr.whiteColor, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10 *
                                              6,
                                          child: Text(
                                            chosen[index],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: vr.whiteColor,
                                              fontFamily: vr.basicFont,
                                              height: 1.75,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          child: IconButton(
                                            icon: Icon(Icons.info_outline,
                                                color: vr.whiteColor),
                                            onPressed: (() {
                                              var tmp = 0;
                                              for (var i = 0;
                                                  i < exercises.length;
                                                  i++) {
                                                if (chosen[index] ==
                                                    exercises[i]["name"])
                                                  tmp = i;
                                              }
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        workoutInfoScreen(
                                                          exercise:
                                                              exercises[tmp]
                                                                  ['name'],
                                                          category:
                                                              exercises[tmp]
                                                                  ['category'],
                                                          equipment:
                                                              exercises[tmp]
                                                                  ['equipment'],
                                                          force: exercises[tmp]
                                                              ['force'],
                                                          instructions: exercises[
                                                                  tmp]
                                                              ['instructions'],
                                                          level: exercises[tmp]
                                                              ['level'],
                                                          mechanic:
                                                              exercises[tmp]
                                                                  ['mechanic'],
                                                          primaryMuscle: exercises[
                                                                  tmp]
                                                              ['primaryMuscle'],
                                                          secondaryMuscle:
                                                              exercises[tmp][
                                                                  'secondaryMuscle'],
                                                        )),
                                              );
                                            }),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          child: IconButton(
                                            icon: Icon(Icons.delete,
                                                color: vr.whiteColor),
                                            onPressed: (() {
                                              setState(() {
                                                delete(chosen[index]);
                                              });
                                              print(chosen);
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          5 *
                                          4,
                                      child: TextFormField(
                                        controller: _controllers[index],
                                        validator: (String? value) {
                                          if (value!.isEmpty)
                                            return 'Please enter the number of sets';
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Sets',
                                          labelStyle: TextStyle(
                                            fontFamily: vr.basicFont,
                                            fontSize: 18,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: vr.orangeColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  ),
                  // ),
                ),
                GestureDetector(
                    child: Center(
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 10 * 9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            color: vr.orangeColor,
                          ),
                          child: Center(
                            child: Text(
                              'Add Exercises',
                              style: TextStyle(
                                fontSize: 20,
                                color: vr.whiteColor,
                                fontFamily: vr.basicFont,
                                height: 1.75,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    }),
                SizedBox(height: 40),
                GestureDetector(
                    child: Center(
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 10 * 9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            color: vr.orangeColor,
                          ),
                          child: Center(
                            child: Text(
                              'Save Workout',
                              style: TextStyle(
                                fontSize: 20,
                                color: vr.whiteColor,
                                fontFamily: vr.basicFont,
                                height: 1.75,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                    onTap: () {
                      proceed = true;
                      if (!(_formKey.currentState!.validate())) {
                        showNameToast();
                        proceed = false;
                      }
                      // for (int i = 0; i < _controllers.length; i++) {
                      //   if (!(_formKey2.currentState!.validate())) {
                      //     showSetToast();
                      //     proceed = false;
                      //     break;
                      //   }
                      // }
                      if (proceed) saveWorkout();
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5 * 4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: exercises.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    child: ListTile(
                      title: Text(exercises[index]['name']),
                      subtitle: Text(exercises[index]['primaryMuscles'][0]),
                      trailing: Column(children: [
                        IconButton(
                          icon: Icon(Icons.help),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => workoutInfoScreen(
                                        exercise: exercises[index]['name'],
                                        category: exercises[index]['category'],
                                        equipment: exercises[index]
                                            ['equipment'],
                                        force: exercises[index]['force'],
                                        instructions: exercises[index]
                                            ['instructions'],
                                        level: exercises[index]['level'],
                                        mechanic: exercises[index]['mechanic'],
                                        primaryMuscle: exercises[index]
                                            ['primaryMuscle'],
                                        secondaryMuscle: exercises[index]
                                            ['secondaryMuscle'],
                                      )),
                            );
                          },
                        )
                      ]),
                    ),
                    onTap: () {
                      setState(() {
                        chosen.add(exercises[index]['name']);
                      });
                      Navigator.pop(context);
                      print(chosen);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
