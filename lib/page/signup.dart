// ignore_for_file: prefer_const_constructors, unnecessary_this, use_key_in_widget_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/page/login.dart';
import 'package:hashtag_fitness/services/authentication.dart';

import 'package:hashtag_fitness/variables.dart' as vr;

import 'errorHandling.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = new GlobalKey<FormState>();

  late String name, email, password;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email

  // String validateEmail(String value) {
  //   Pattern pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   // ignore: unnecessary_new
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value))
  //     // ignore: curly_braces_in_flow_control_structures
  //     return 'Enter Valid Email';
  //   else
  //     // ignore: curly_braces_in_flow_control_structures
  //     return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formKey,
          child: _buildSignupForm(),
        ),
      ),
    );
  }

  _buildSignupForm() {
    final TextEditingController _pass = TextEditingController();
    final TextEditingController _confirmPass = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ListView(
        children: [
          SizedBox(height: 75),
          Container(
            height: 125,
            width: 200,
            child: Stack(
              children: [
                Text(
                  'Signup',
                  style: TextStyle(
                    fontFamily: vr.basicFont,
                    fontSize: 50,
                    color: vr.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          //NAME
          SizedBox(height: 15),
          TextFormField(
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: vr.orangeColor),
                ),
              ),
              onChanged: (value) {
                this.name = value;
              },
              validator: (value) => value!.isEmpty ? 'Name is required' : null),
          //EMAIL
          SizedBox(height: 15),
          TextFormField(
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              decoration: InputDecoration(
                labelText: 'EMAIL',
                labelStyle: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: vr.orangeColor),
                ),
              ),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Email is required' : null),
          SizedBox(height: 15),
          //Password

          TextFormField(
              controller: _pass,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                labelStyle: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: vr.orangeColor),
                ),
              ),
              obscureText: true,
              onChanged: (value) {
                this.password = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Password is required' : null),
          SizedBox(height: 15),
          //Confirm password
          TextFormField(
            controller: _confirmPass,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              labelText: 'RETYPE PASSWORD',
              labelStyle: TextStyle(
                fontFamily: vr.basicFont,
                fontSize: 15,
                color: Colors.white.withOpacity(0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: vr.orangeColor),
              ),
            ),
            obscureText: true,
            onChanged: (value) {
              this.password = value;
            },
            // validator: (value) =>
            //     value!.isEmpty ? 'Confirm password is required' : null

            validator: (value) {
              if (value!.isEmpty) return 'Confirm password is required';
              if (value != _pass.text) return 'Password does not match';
              return null;
            },
          ),
          SizedBox(height: 50),
          //Signup
          Bounceable(
            onTap: () {
              if (checkFields()) {
                AuthService().signUp(name, email, password).then((userCreds) {
                  Navigator.of(context).pop();
                }).catchError(
                  (e) {
                    ErrorHandle().errorDialog(context, e);
                  },
                );
              }
            },
            child: Container(
              height: 50,
              child: Material(
                borderRadius: BorderRadius.circular(25),
                color: vr.orangeColor,
                elevation: 7,
                child: Center(
                  child: Text(
                    'SIGN UP',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Go back
              Bounceable(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Go back',
                  style: TextStyle(
                      color: vr.orangeColor,
                      fontFamily: vr.basicFont,
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
