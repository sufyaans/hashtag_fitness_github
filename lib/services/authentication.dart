// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hashtag_fitness/home.dart';
import 'package:hashtag_fitness/page/errorHandling.dart';
import 'package:hashtag_fitness/page/login.dart';
import 'package:hashtag_fitness/services/database.dart';

class AuthService {
  //Determine if the user is authenticated
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return LoginPage();
          }
        });
  }

  // create user obj based on firebase user
  // User _userFromFirebaseUser(UserCredential user) {
  //   return user != null ? User(uid: user.uid) : null;
  // }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign in
  signIn(String email, String password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((val) {
      print('signed in');
    }).catchError((e) {
      ErrorHandle().errorDialog(context, e);
    });
  }

  // //Sign up
  signUp(String name, String email, String password) async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    await DatabaseService(uid: user!.uid).updateUserData(name, email, password);
    //return _userFromFirebaseUser(user);

    return result;
  }

  //Sign up
  // signUp(String email, String password) {
  //   return FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email, password: password);
  // }

  //Reset password
  resetPass(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}

//Google login
class GoogleSignInProvider extends ChangeNotifier {
  final googlSignin = GoogleSignIn();
  AuthService authService = AuthService();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googlSignin.signIn();
    if (googleUser == null) {
      return;
    }

    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    //Double check this works (A User collection is made for users signing in with google)
    await authService.signUp(_user!.displayName!, _user!.email, "");
    notifyListeners();
  }
}
