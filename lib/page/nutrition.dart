import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/page/logMeal.dart';
import 'package:hashtag_fitness/page/settings.dart';

class Nutrition extends StatefulWidget {
  @override
  _NutritionState createState() => _NutritionState();
}

Color orangeColor = Colors.deepOrange;
Color backGround = Color(0xFF03111C);
String basicFont = 'roughMotion';

class _NutritionState extends State<Nutrition> {
  String basicFont = 'roughMotion';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: Text(
          'Nutrition',
          style: TextStyle(fontFamily: basicFont),
        ),
        backgroundColor: Color(0xFF03111C),
        actions: [
          IconButton(
              icon: Icon(Icons.calendar_today),
              tooltip: 'Calendar',
              //color: Colors.black,
              onPressed: () => {
                    // View history of meals
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
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
                  color: orangeColor,
                  elevation: 7,
                  child: Center(
                    child: Text(
                      'LOG A MEAL',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: basicFont,
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
                fontFamily: basicFont,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
