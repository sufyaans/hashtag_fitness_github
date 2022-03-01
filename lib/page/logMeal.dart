import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'measurement.dart';
import 'package:hashtag_fitness/variables.dart' as vr;

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({Key? key}) : super(key: key);

  @override
  _LogMealScreenState createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.backGround,
      appBar: AppBar(
        title: Text(
          'Add a Meal',
          style: TextStyle(fontFamily: vr.basicFont),
        ),
        backgroundColor: vr.backGround,
      ),
      body: LogMeal(),
    );
  }
}

class LogMeal extends StatefulWidget {
  const LogMeal({Key? key}) : super(key: key);

  @override
  _LogMealState createState() => _LogMealState();
}

class _LogMealState extends State<LogMeal> {
  late String mealType, itemsConsumed, quantity, calories, fat, carbs, protein;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          //Type of meal
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Type of Meal',
              labelStyle: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.mealType = value;
            },
            //validator: (value) => value!.isEmpty ? 'Type of Meal is required' : null
          ),

          //Items consumed
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Items consumed',
              labelStyle: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.itemsConsumed = value;
            },
            //validator: (value) => value!.isEmpty ? 'Items consumed is required' : null
          ),

          //Quantity
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Quantity',
              labelStyle: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.quantity = value;
            },
            //validator: (value) => value!.isEmpty ? 'Quantity is required' : null
          ),

          //Total calories
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Total calories (kcal)',
              labelStyle: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.calories = value;
            },
            //validator: (value) => value!.isEmpty ? 'Type of Meal is required' : null
          ),

          //Fat
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Fat (g)',
              labelStyle: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.fat = value;
            },
            //validator: (value) => value!.isEmpty ? 'Fat is required' : null
          ),

          //Carbs
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Carbs (g)',
              labelStyle: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.carbs = value;
            },
            //validator: (value) => value!.isEmpty ? 'Carbs is required' : null
          ),

          //Protein
          SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'Protein (g)',
              labelStyle: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            onChanged: (value) {
              this.protein = value;
            },
            //validator: (value) => value!.isEmpty ? 'Protein is required' : null
          ),

          //Save Meal
          SizedBox(height: 50),
          Bounceable(
            onTap: () {
              //Save meal
            },
            child: Container(
              height: 40,
              child: Material(
                borderRadius: BorderRadius.circular(25),
                //shadowColor: Colors.orangeAccent,
                color: vr.orangeColor,
                elevation: 7,
                child: Center(
                  child: Text(
                    'Log meal',
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
  }
}
