// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You are logged in'),
          ElevatedButton(
            onPressed: () {
              //SignOut (Not working)
              //AuthService().signOut();

              //Work around to Signout method from services/authentication
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            child: Center(
              child: Text(
                'LOG OUT',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
