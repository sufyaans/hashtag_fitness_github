import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:hashtag_fitness/services/authentication.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = new GlobalKey<FormState>();

  late String email;
  Color orangeColor = Colors.deepOrange;
  String basicFont = 'Trueno';

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
          child: _buildPasswordForm(),
        ),
      ),
    );
  }

  _buildPasswordForm() {
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
                    'Reset Password',
                    style: TextStyle(
                      fontFamily: basicFont,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
          SizedBox(height: 25),
          TextFormField(
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                    fontFamily: basicFont,
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: orangeColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Email is required' : null),
          SizedBox(height: 50),
          //RESET
          Bounceable(
            onTap: () {
              if (checkFields()) {
                //Not working
                AuthService().resetPass(email);
                //FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                Navigator.of(context).pop();
              }
            },
            child: Container(
              height: 50,
              child: Material(
                borderRadius: BorderRadius.circular(25),
                color: orangeColor,
                elevation: 7,
                child: Center(
                  child: Text(
                    'RESET',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: basicFont,
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
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Go back',
                  style: TextStyle(
                      color: orangeColor,
                      fontFamily: basicFont,
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
