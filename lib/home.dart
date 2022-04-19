// ignore_for_file: use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'page/exercise.dart';
import 'page/measurement.dart';
import 'page/nutrition.dart';
import 'page/dashboard.dart';
import 'page/workout.dart';
import 'package:hashtag_fitness/variables.dart' as vr;

class Home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Exercise(),
    Measurement(),
    Nutrition(),
    DashboardScreen(),
    Workout()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardScreen();

// NAVIGATION BAR
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: vr.backGround, //other colour option 0xFF010e17

        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Dashboard
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = DashboardScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.space_dashboard,
                          color:
                              currentTab == 0 ? vr.orangeColor : vr.greyColor,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              fontSize: 13,
                              color: currentTab == 0
                                  ? vr.orangeColor
                                  : vr.greyColor),
                        ),
                      ],
                    ),
                  ),

                  //Workout
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Workout();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color:
                              currentTab == 1 ? vr.orangeColor : vr.greyColor,
                        ),
                        Text(
                          'Workout',
                          style: TextStyle(
                              fontSize: 13,
                              color: currentTab == 1
                                  ? vr.orangeColor
                                  : vr.greyColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nutrition
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Nutrition();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant,
                          color:
                              currentTab == 2 ? vr.orangeColor : vr.greyColor,
                        ),
                        Text(
                          'Nutrition',
                          style: TextStyle(
                              fontSize: 13,
                              color: currentTab == 2
                                  ? vr.orangeColor
                                  : vr.greyColor),
                        ),
                      ],
                    ),
                  ),

                  // Exercise
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Exercise();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          color:
                              currentTab == 3 ? vr.orangeColor : vr.greyColor,
                        ),
                        Text(
                          'Exercise',
                          style: TextStyle(
                              fontSize: 13,
                              color: currentTab == 3
                                  ? vr.orangeColor
                                  : vr.greyColor),
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
