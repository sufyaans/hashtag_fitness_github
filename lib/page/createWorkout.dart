// ignore_for_file: prefer_const_constructors, camel_case_types, file_names, prefer_const_literals_to_create_immutables, unnecessary_new, prefer_final_fields, unused_field, must_call_super, annotate_overrides, await_only_futures, prefer_is_empty, sized_box_for_whitespace, curly_braces_in_flow_control_structures, dead_code, must_be_immutable
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './detailPage.dart';

class CreateWorkoutScreen extends StatefulWidget {
  bool newScreen = false;
  CreateWorkoutScreen({required this.newScreen, Key? key}) : super(key: key);

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: createWorkout(
        newScreen: widget.newScreen,
      ),
    );
  }
}

class createWorkout extends StatefulWidget {
  bool newScreen = false;
  createWorkout({required this.newScreen, Key? key}) : super(key: key);

  @override
  _createWorkoutState createState() => _createWorkoutState();
}

var chosen = [];
TextEditingController workoutName = TextEditingController();
List<TextEditingController> _controllers = [];

class _createWorkoutState extends State<createWorkout> {
  static var exercises = [];
  var size = 0;
  var sets = [];
  bool proceed = true;
  ScrollController _controller = new ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  void initState() {
    if (widget.newScreen == true) {
      setState(() {
        chosen = [];
        workoutName = TextEditingController();
        _controllers = [];
      });
    } else {
      if (size != chosen.length) {
        var tmp = chosen;
        chosen = [];
        for (var t in tmp) {
          setState(() {
            chosen.add(t);
          });
        }
        size = chosen.length;
      }
    }
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
    var date = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy_MM_dd_HH_mm_ss');
    String time = "";
    setState(() {
      time = formatter.format(date);
    });
    for (int i = 0; i < _controllers.length; i++) {
      sets.add(_controllers[i].text);
    }
    String uname = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uname)
        .collection("WorkoutTemplates")
        .doc(time)
        .set({
      "timestamp": DateTime.now(),
      "name": workoutName.text,
      "workoutList": chosen,
      "sets": sets,
    }).then((value) {
      workoutName.clear();
    });
  }

  Stream<QuerySnapshot> getExercises() {
    var firestore = FirebaseFirestore.instance;
    Stream<QuerySnapshot<Map<String, dynamic>>> qn =
        firestore.collection("exercises").snapshots();
    return qn;
  }

  navigateToDetail(QueryDocumentSnapshot exercise) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SafeArea(
              child: DetailPage(
                exercise: exercise,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getExercises(),
        builder: (context, snapshot) {
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
                              if (value!.isEmpty)
                                return 'This field is required';
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
                        // child: Container(

                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          controller: _controller,
                          shrinkWrap: true,
                          itemCount: (chosen.length != 0) ? chosen.length : 0,
                          itemBuilder: (BuildContext context, int index) {
                            _controllers.add(new TextEditingController());
                            return ListTile(
                              title: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        10 *
                                        9,
                                    decoration: BoxDecoration(
                                        color: vr.backGround,
                                        border: Border.all(
                                            color: vr.whiteColor, width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
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

                                                    navigateToDetail(snapshot
                                                        .data!.docs[tmp]);
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
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5 *
                                                4,
                                            child: TextFormField(
                                              controller: _controllers[index],
                                              validator: (String? value) {
                                                if (value!.isEmpty)
                                                  return 'Please enter the number of sets';
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                              decoration: InputDecoration(
                                                labelText: 'Sets',
                                                labelStyle: TextStyle(
                                                  fontFamily: vr.basicFont,
                                                  fontSize: 18,
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
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
                      ),
                      GestureDetector(
                          child: Center(
                            child: Container(
                                height: 40,
                                width:
                                    MediaQuery.of(context).size.width / 10 * 9,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
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
                                width:
                                    MediaQuery.of(context).size.width / 10 * 9,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
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

                            if (proceed) {
                              saveWorkout();
                              Navigator.pop(context);
                            }
                          }),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  bool searchState = false;

  Widget _buildPopupDialog(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getExercises(),
        builder: (context, snapshot) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (!snapshot.hasData) {
                        return;
                      }
                      showSearch(
                          context: context,
                          delegate: ExerciceSearch(snapshot.data!));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height / 100),
                      child: Text(
                        "Search...",
                        style: TextStyle(
                          fontFamily: vr.basicFont,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4 * 3,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          child: ListTile(
                            title: Text(exercises[index]['name']),
                            subtitle:
                                Text(exercises[index]['primaryMuscles'][0]),
                            trailing: Column(children: [
                              IconButton(
                                icon: Icon(Icons.help),
                                onPressed: () {
                                  navigateToDetail(snapshot.data!.docs[index]);
                                },
                              )
                            ]),
                          ),
                          onTap: () {
                            setState(() {
                              chosen.add(exercises[index]['name']);
                            });
                            Navigator.pop(context);
                          });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

//Search function
class ExerciceSearch extends SearchDelegate {
  QuerySnapshot exerices;
  ExerciceSearch(this.exerices);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(Icons.adaptive.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    var searchResult = exerices.docs.where((element) =>
        (element.get('name') as String)
            .toLowerCase()
            .contains(query.toLowerCase()));

    return searchResult.isEmpty
        ? Center(child: Text('Not found'))
        : ListView.builder(
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              var item = searchResult.elementAt(index);
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      chosen.add(item['name']);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateWorkoutScreen(
                                    newScreen: false,
                                  )));
                    });
                  },
                  tileColor: const Color(0xFFF4F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  title: Text(item['name']),
                  subtitle: Text(item["primaryMuscles"][0]),
                );
              });
            });
  }

  //adding searching suggestion
  @override
  Widget buildSuggestions(BuildContext context) {
    var searchResult = exerices.docs.toList();
    searchResult.shuffle();

    return true
        ? Center(
            child: Text('Type to search'),
          )
        : ListView.builder(
            itemCount: searchResult.length > 4 ? 4 : searchResult.length,
            itemBuilder: (context, index) {
              var item = searchResult.elementAt(index);
              return ListTile(
                tileColor: const Color(0xFFF4F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                title: Text(item['name']),
                subtitle: Text(item["primaryMuscles"][0]),
              );
            });
  }
}
