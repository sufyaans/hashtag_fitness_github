import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('Reset Password',
                      style: TextStyle(
                        fontFamily: 'Trueno',
                        fontSize: 40,
                        color: Colors.white,
                      )),
                ],
              )),
          SizedBox(height: 25.0),
          TextFormField(
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.white.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: orangeColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Email is required' : null),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields()) {
                //Not working
                AuthService().resetPass(email);
                //FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                Navigator.of(context).pop();
              }
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    color: orangeColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('RESET',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back',
                    style: TextStyle(
                        color: orangeColor,
                        fontFamily: 'Trueno',
                        fontSize: 18,
                        decoration: TextDecoration.underline)))
          ])
        ]));
  }
}
