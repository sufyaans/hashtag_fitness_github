import 'package:flutter/material.dart';
import 'page/exercise.dart';
import 'page/measurement.dart';
import 'page/nutrition.dart';
import 'page/dashboard.dart';
import 'page/workout.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF03111C), //other colour option 0xFF010e17
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
                    //minWidth: 40,
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
                              currentTab == 3 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          'Dash',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  //Workout
                  MaterialButton(
                    //minWidth: 40,
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
                        currentTab = 2;
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
                        currentTab = 3;
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
