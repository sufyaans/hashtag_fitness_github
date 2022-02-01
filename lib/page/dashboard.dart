import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'measurement.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

Color orangeColor = Colors.deepOrange;
Color backGround = Color(0xFF03111C);
String basicFont = 'roughMotion';

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: AppBar(
        title: Text(
          'DASHBOARD',
          style: TextStyle(fontFamily: basicFont),
        ),
        backgroundColor: backGround,
      ),
      body: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          //Welcome and login
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: <Widget>[
                        Text(
                          "Welcome to #FITNESS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: basicFont,
                            fontWeight: FontWeight.w900,
                          ),
                        ), //Hello + user's name/email address
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        //FirebaseAuth.instance.signOut();
                        //Navigator.of(context).pop();
                        AuthService().signOut();
                        Navigator.of(context).pop;
                      },
                      icon: Icon(Icons.logout),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Submenu navigation
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shortcuts',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: basicFont,
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        createWorkout(),
                        logMeal(),
                        logMeasurement(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: basicFont,
                        ),
                      ),
                    ],
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,

                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Create a workout
class createWorkout extends StatelessWidget {
  const createWorkout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        //Create a workout template
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: Container(
          height: 80,
          width: 140,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.white, //Change colour later on
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add), //Add workout image
                  SizedBox(width: 10),
                  // Text(
                  //   "Create a workout",
                  //   style: TextStyle(
                  //     fontFamily: basicFont,
                  //     fontSize: 15,
                  //   ),
                  // ),
                ],
              ),
              Text(
                "Create a workout",
                style: TextStyle(
                  fontFamily: basicFont,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Log a meal
class logMeal extends StatelessWidget {
  const logMeal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        //log a Meal
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: Container(
          height: 80,
          width: 140,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.white, //Change colour later on
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.restaurant,
                  ), //Add workout image
                  SizedBox(width: 10),
                  // Text(
                  //   "Create a workout",
                  //   style: TextStyle(
                  //     fontFamily: basicFont,
                  //     fontSize: 15,
                  //   ),
                  // ),
                ],
              ),
              Text(
                "Log a meal",
                style: TextStyle(
                  fontFamily: basicFont,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Log a Measurement
class logMeasurement extends StatelessWidget {
  const logMeasurement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Measurement(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: Container(
          height: 80,
          width: 140,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.white, //Change colour later on
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.straighten,
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Text(
                "Log a Measurement",
                style: TextStyle(
                  fontFamily: basicFont,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
