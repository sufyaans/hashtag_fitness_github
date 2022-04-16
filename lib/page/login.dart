// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_new, sized_box_for_whitespace, unnecessary_this, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/page/forgotPassword.dart';
import 'package:hashtag_fitness/page/signup.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'package:provider/provider.dart';

import 'package:hashtag_fitness/variables.dart' as vr;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  late String email, password;

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
    return Container(
      child: Scaffold(
        backgroundColor: vr.backGround,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: _buildLoginForm(),
          ),
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
              child: Stack(
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontFamily: vr.funkyFont,
                      fontSize: 90,
                      color: vr.whiteColor,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Text(
                      '#FITNESS',
                      style: TextStyle(
                        fontFamily: vr.funkyFont,
                        fontSize: 80,
                        color: vr.orangeColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
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
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
            ),
            TextFormField(
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
                  )),
              obscureText: true,
              onChanged: (value) {
                this.password = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Password is required' : null,
            ),
            SizedBox(height: 5),
            //Forgot Password
            Bounceable(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPassword(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment(1, 0),
                padding: EdgeInsets.only(top: 15, left: 20),
                child: InkWell(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: vr.orangeColor,
                        fontFamily: vr.basicFont,
                        fontSize: 18,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            //Email Login
            Bounceable(
              onTap: () {
                //Email Password Login
                if (checkFields()) {
                  AuthService().signIn(email, password, context);
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
                      'LOGIN',
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
            //Google Login
            Bounceable(
              onTap: () {
                //Google Login
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              child: Container(
                height: 50,
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
                    children: [
                      Center(
                        child: ImageIcon(
                          AssetImage('assets/google.png'),
                          color: vr.whiteColor,
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
                            fontFamily: vr.basicFont,
                            color: vr.whiteColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'New to Hashtag Fitness?',
                style: TextStyle(
                  color: vr.whiteColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 5),
              Bounceable(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      color: vr.orangeColor,
                      fontFamily: vr.basicFont,
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                ),
              ),
            ]),
          ],
        ));
  }
}
