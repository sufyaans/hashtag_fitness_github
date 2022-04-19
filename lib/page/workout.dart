// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, library_prefixes, unnecessary_new, prefer_final_fields, unused_local_variable, await_only_futures, must_call_super, annotate_overrides, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/page/createWorkout.dart';
import 'package:hashtag_fitness/page/workoutCalendar.dart';
import 'package:hashtag_fitness/page/workoutDetail.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'package:hashtag_fitness/page/performWorkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  Stream<QuerySnapshot> getExercises() {
    var firestore = FirebaseFirestore.instance;
    Stream<QuerySnapshot<Map<String, dynamic>>> qn = firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("WorkoutTemplates")
        .snapshots();
    return qn;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getExercises(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: vr.backGround,
            appBar: AppBar(
              title: Text(
                'Workout',
                style: TextStyle(fontFamily: vr.basicFont),
              ),
              backgroundColor: vr.backGround,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: () {
                    // if (!snapshot.hasData) {
                    //   return;
                    // }
                    showSearch(
                        context: context,
                        delegate: ExerciceSearch(snapshot.data!));
                  },
                ),
                IconButton(
                    icon: Icon(Icons.calendar_today),
                    tooltip: 'Calendar',
                    onPressed: () => {
                          // View workout calendar
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => workoutCalendar(),
                            ),
                          ),
                        }),
              ],
            ),
            body: WorkoutPage(),
          );
        });
  }
}

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  var workouts = [];
  var workoutsName = [];
  initState() {
    getData();
  }

  CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('WorkoutTemplates');

  getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final workName = querySnapshot.docs.map((doc) => doc.id).toList();
    setState(() {
      workouts = allData;
      workouts = List.from(workouts.reversed);
      workoutsName = List.from(workName.reversed);
    });
  }

  deleteWorkout(String name) async {
    final collection = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('WorkoutTemplates');
    await collection.doc(name).delete();
    getData();
  }

  bottomSheet(var i, var name, var workoutName) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: Navigator.of(context).pop,
          child: GestureDetector(onTap: () {}, child: child),
        );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: makeDismissible(
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            maxChildSize: 0.8,
            minChildSize: 0.2,
            builder: (BuildContext context, ScrollController scrollController) {
              int index = 0;
              return Container(
                decoration: BoxDecoration(
                  color: vr.whiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(18.0)),
                ),
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  children: [
                    Center(
                      child: Text(
                        workouts[i]['name'],
                        style: TextStyle(
                          fontFamily: vr.basicFont,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListView.builder(
                        itemCount: workouts[i]['workoutList'].length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            trailing: Padding(
                                padding: EdgeInsetsDirectional.only(start: 10),
                                child: Text(
                                  'Sets: ' + workouts[i]["sets"][index],
                                  style: TextStyle(
                                    fontFamily: vr.basicFont,
                                    fontSize: 18,
                                    color: vr.orangeColor,
                                  ),
                                )),
                            title: Padding(
                                padding: EdgeInsetsDirectional.only(end: 10),
                                child: Text(
                                  workouts[i]["workoutList"][index],
                                  style: TextStyle(
                                    fontFamily: vr.basicFont,
                                    fontSize: 18,
                                  ),
                                )),
                          );
                        }),
                    SizedBox(height: 10),
                    Bounceable(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context, workoutsName[i], i),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        child: Material(
                          borderRadius: BorderRadius.circular(24),
                          color: vr.errorColor,
                          elevation: 7,
                          child: Center(
                            child: Text(
                              'DELETE WORKOUT',
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
                    SizedBox(height: 10),
                    Bounceable(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PerformWorkout(
                                workoutName: workoutName, name: name),
                          ),
                        );
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
                              'START WORKOUT',
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
            },
          ),
        ),
      ),
    );
  }

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            Bounceable(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateWorkoutScreen(
                      newScreen: true,
                    ),
                  ),
                );
              },
              child: Container(
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: vr.orangeColor,
                  elevation: 7,
                  child: Center(
                    child: Text(
                      'CREATE A WORKOUT TEMPLATE',
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
            SizedBox(height: 20),
            Text(
              "Saved Workouts",
              style: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: vr.whiteColor,
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  controller: _controller,
                  shrinkWrap: true,
                  itemCount: workouts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ListTile(
                        leading: Icon(Icons.list),
                        tileColor: const Color(0xFFF4F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Text(
                          workouts[index]["name"],
                          style: TextStyle(
                            fontFamily: vr.basicFont,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          bottomSheet(index, workouts[index]["name"],
                              workoutsName[index]);
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, String name, int index) {
    return AlertDialog(
      title: Text(
        'Delete',
        style: TextStyle(
          color: vr.whiteColor,
        ),
      ),
      content: Text(
        'Are you sure you want to delete this workout',
        style: TextStyle(
          color: vr.whiteColor,
        ),
      ),
      backgroundColor: vr.backGround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        //Yes
        Bounceable(
          onTap: () {
            setState(() {
              deleteWorkout(name);
              workouts.remove(workouts[index]);
              Navigator.pop(context);
              Navigator.pop(context);
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(24),
              color: vr.orangeColor,
              elevation: 7,
              child: Center(
                child: Text(
                  'Yes',
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
        SizedBox(
          height: 10,
        ),
        //NO
        Bounceable(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(24),
              color: vr.errorColor,
              elevation: 7,
              child: Center(
                child: Text(
                  'No',
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
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

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
              return ListTile(
                //leading: Icon(Icons.list),
                tileColor: const Color(0xFFF4F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                title: Text(
                  item["name"],
                  style: TextStyle(
                    fontFamily: vr.basicFont,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => SafeArea(
                              child: ViewWorkoutPage(
                            i: index,
                            name: item["name"],
                            workoutName: item.id,
                            workoutSearch: item,
                          )));
                },
              );
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
