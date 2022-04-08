import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/page/logMeal.dart';
import 'package:hashtag_fitness/page/nutritionCalendar.dart';

import 'package:hashtag_fitness/variables.dart' as vr;

class Nutrition extends StatefulWidget {
  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          'Nutrition',
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
                  MaterialPageRoute(builder: (context) => nutritionCalendar()),
                );
              }),
        ],
      ),
      body: NutritionPage(),
    );
  }
}

class NutritionPage extends StatefulWidget {
  const NutritionPage({Key? key}) : super(key: key);

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  var nutritions = [];
  initState() {
    getData();
  }

  CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Nutrition');

  getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      nutritions = allData;
    });
    print(allData);
  }

  bottomSheet(var i, var name) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: Navigator.of(context).pop,
          child: GestureDetector(onTap: () {}, child: child),
        );

    //Need to fix the scroll behaviour
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
                    // Add meal data
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
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
          children: [
            Bounceable(
              onTap: () {
                //Log a meal
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LogMealScreen(),
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
                      'LOG A MEAL',
                      style: TextStyle(
                          color: vr.whiteColor,
                          fontFamily: vr.basicFont,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Recent Meals",
              style: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: vr.whiteColor,
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: nutritions.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // child: Bounceable(
                  //   onTap: () {
                  //     //bottomSheet(index, nutritions[index]["Type of Meal"]);
                  //   },
                  child: ListTile(
                    tileColor: const Color(0xFFF4F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    // trailing: Text(
                    //   workouts[index]["name"],
                    //   style: TextStyle(
                    //     fontFamily: vr.basicFont,
                    //     fontSize: 18,
                    //     color: vr.whiteColor,
                    //   ),
                    // ),
                    title: Text(
                      nutritions[index]["Type of Meal"],
                      style: TextStyle(
                        fontFamily: vr.basicFont,
                        fontSize: 18,
                        //color: vr.black,
                      ),
                    ),
                    subtitle: Text(
                      nutritions[index]["Items Consumed"],
                    ),

                    onTap: () {
                      bottomSheet(index, nutritions[index]["Type of Meal"]);
                    },
                  ),
                  // ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
