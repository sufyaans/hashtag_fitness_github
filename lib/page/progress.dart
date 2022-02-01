// import 'package:flutter/material.dart';
// import 'measurement.dart';

// class Progress extends StatefulWidget {
//   @override
//   _ProgressState createState() => _ProgressState();
// }

// Color orangeColor = Colors.deepOrange;
// Color backGround = Color(0xFF03111C);
// String basicFont = 'roughMotion';

// class _ProgressState extends State<Progress> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backGround,
//       appBar: AppBar(
//         title: Text(
//           'PROGRESS',
//           style: TextStyle(fontFamily: basicFont),
//         ),
//         backgroundColor: backGround,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.straighten),
//             tooltip: 'Measure',
//             //color: Colors.black,
//             onPressed: () => {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => Measurement(),
//                 ),
//               ),
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text('Progress Screen', style: TextStyle(fontSize: 40)),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hashtag_fitness/page/login.dart';
import 'package:hashtag_fitness/services/authentication.dart';
import 'measurement.dart';

class Progress extends StatefulWidget {
  @override
  _ProgressState createState() => _ProgressState();
}

Color orangeColor = Colors.deepOrange;
Color backGround = Color(0xFF03111C);
String basicFont = 'roughMotion';

class _ProgressState extends State<Progress> {
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
          Padding(
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
        ],
      ),
    );
  }
}
