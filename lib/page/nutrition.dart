// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_new, prefer_final_fields, curly_braces_in_flow_control_structures, must_call_super, annotate_overrides, use_key_in_widget_constructors

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
  var docnames = [];
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
    final tmpData = querySnapshot.docs.map((doc) => doc.id).toList();
    setState(() {
      nutritions = allData;
      docnames = tmpData;
    });
    nutritions = List.from(nutritions.reversed);
    docnames = List.from(docnames.reversed);
  }

  String parseDate(String timeDate) {
    String day = "";
    String month = "";
    String year = "";
    String time = "";
    String tmp = "";
    List<String> months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    for (int i = 0; i < timeDate.length; i++) {
      if (i == 2 || i == 3)
        year += timeDate[i];
      else if (i == 4)
        year += " ";
      else if (i == 5) {
        String tmptmp = timeDate[i] + timeDate[i + 1];
        int tmp2 = int.parse(tmptmp);
        month += months[tmp2] + " ";
        i++;
      } else if (i == 8 || i == 9)
        day += timeDate[i];
      else if (i == 10)
        day += " ";
      else if (i == 13)
        time += ":";
      else if (i >= 11 && i <= 15) time += timeDate[i];
      if (i == 15) time += " ";
    }
    tmp = time + day + month + year;
    return tmp;
  }

  bottomSheet() {
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
            initialChildSize: 0.3,
            maxChildSize: 0.5,
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
                        (nutritions[index]["Type of Meal"]).toString(),
                        style: TextStyle(
                          fontFamily: vr.basicFont,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Items Consumed: ' +
                          (nutritions[index]['Items Consumed']).toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Quantity: ' + (nutritions[index]['Quantity']).toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Total Calories (Kcal): ' +
                          (nutritions[index]['Total Calories (Kcal)'])
                              .toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Fat (g): ' + (nutritions[index]['Fat (g)']).toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Carbs (g): ' +
                          (nutritions[index]['Carbs (g)']).toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Protein (g): ' +
                          (nutritions[index]['Protein (g)']).toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    // ------------
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
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                controller: _controller,
                physics: ScrollPhysics(),
                itemCount: nutritions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ListTile(
                        tileColor: const Color(0xFFF4F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Text(
                          nutritions[index]["Type of Meal"],
                          style: TextStyle(
                            fontFamily: vr.basicFont,
                            fontSize: 18,
                            //color: vr.black,
                          ),
                        ),
                        subtitle: Text(
                          parseDate(docnames[index]),
                        ),
                        onTap: () {
                          bottomSheet();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
