// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'page/exercise.dart';
import 'page/measurement.dart';
import 'page/nutrition.dart';
import 'page/progress.dart';
import 'page/workout.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

Color orangeColor = Colors.deepOrange;
Color backGround = Color(0xFF03111C);
String basicFont = 'roughMotion';

// ignore: camel_case_types
class _homeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Exercise(),
    Measurement(),
    Nutrition(),
    Progress(),
    Workout()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Workout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: backGround,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Workout
                  MaterialButton(
                    //minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Workout();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add, //Fix icon
                          color:
                              currentTab == 0 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          'Workout',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  // Nutrition
                  MaterialButton(
                    //minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Nutrition();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant, //Fix icon
                          color:
                              currentTab == 1 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          'Nutrition',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Exercise
                  MaterialButton(
                    //minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Exercise();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center, //Fix Icon
                          color:
                              currentTab == 2 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          'Exercise',
                          style: TextStyle(
                              color: currentTab == 2
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  //Progress
                  MaterialButton(
                    //minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Progress();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pie_chart, //Fix Icon
                          color:
                              currentTab == 3 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          'Progress',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
