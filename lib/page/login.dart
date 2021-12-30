// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hashtag_fitness/page/forgotPassword.dart';
import 'package:hashtag_fitness/page/signup.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'package:provider/provider.dart';

import 'errorHandling.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  late String email, password;
  Color orangeColor = Colors.deepOrange;

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
          child: _buildLoginForm(),
        ),
      ),
    );
  }

  _buildLoginForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          children: [
            SizedBox(
              height: 75,
            ),
            Container(
              height: 125,
              width: 200,
              // ignore: prefer_const_literals_to_create_immutables
              child: Stack(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Text(
                      '#FITNESS',
                      style: TextStyle(
                        fontFamily: 'Trueno',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 97.0,
                  //   left: 175.0,
                  //   child: Container(
                  //     height: 10.0,
                  //     width: 10.0,
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle, color: orangeColor),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5)),
                  //Underline border should be white
                  // border: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white),
                  // ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: orangeColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
            ),
            TextFormField(
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.white.withOpacity(0.5)),
                  //Underline border should be white
                  // border: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white),
                  // ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: orangeColor),
                  )),
              obscureText: true,
              onChanged: (value) {
                this.password = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Password is required' : null,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              child: Container(
                alignment: Alignment(1, 0),
                padding: EdgeInsets.only(top: 15, left: 20),
                child: InkWell(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: orangeColor,
                        fontFamily: 'Trueno',
                        fontSize: 15,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                if (checkFields()) {
                  AuthService().signIn(email, password, context);

                  //Work around to Signin method from services/authentication
                  // FirebaseAuth.instance
                  //     .signInWithEmailAndPassword(
                  //         email: email, password: password)
                  //     .then((val) {
                  //   print('signed in');
                  // }).catchError((e) {
                  //   ErrorHandle().errorDialog(context, e);
                  // });
                }
              },
              child: Container(
                height: 50.0,
                child: Material(
                  borderRadius: BorderRadius.circular(25.0),
                  color: orangeColor,
                  elevation: 7.0,
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Trueno'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                //Google sign in
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              child: Container(
                height: 50.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Center(
                        child: ImageIcon(
                          AssetImage('assets/google.png'),
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Center(
                        child: Text(
                          'Login with Google',
                          style: TextStyle(
                            fontFamily: 'Trueno',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'New to Hashtag Fitness?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      color: orangeColor,
                      fontFamily: 'Trueno',
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                ),
              ),
            ]),
          ],
        ));
  }
}
