// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:hashtag_fitness/page/dashboard.dart';
// import 'package:hashtag_fitness/variables.dart' as vr;

// import 'createWorkout.dart';

// class workoutDetail extends StatefulWidget {
//   const workoutDetail({Key? key}) : super(key: key);

//   @override
//   State<workoutDetail> createState() => _workoutDetailState();
// }

// class _workoutDetailState extends State<workoutDetail> {
//   var workouts = [];
//   initState() {
//     getData();
//   }

//   CollectionReference _collectionRef = FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection('WorkoutTemplates');

//   getData() async {
//     // Get docs from collection reference
//     QuerySnapshot querySnapshot = await _collectionRef.get();

//     // Get data from docs and convert map to List
//     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
//     setState(() {
//       workouts = allData;
//     });
//     print(allData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return getWorkout(context);
//   }

//   Widget makeDismissible({required Widget child}) => GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: Navigator.of(context).pop,
//         child: GestureDetector(onTap: () {}, child: child),
//       );

//   Widget getWorkout(var i) {
//     return makeDismissible(
//         child: DraggableScrollableSheet(
//             initialChildSize: 0.9,
//             maxChildSize: 0.9,
//             minChildSize: 0.5,
//             builder: (BuildContext context, ScrollController scrollController) {
//               int index = 0;
//               return Container(
//                 decoration: BoxDecoration(
//                   color: vr.whiteColor,
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(18.0)),
//                 ),
//                 padding: EdgeInsets.all(16.0),
//                 child: ListView(
//                   shrinkWrap: true,
//                   children: [
//                     ListView.builder(
//                         itemCount: workouts[i]['workoutList'].length,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           return ListTile(
//                             // leading: Icon(Icons.list),
//                             trailing: Padding(
//                                 padding: EdgeInsetsDirectional.only(start: 10),
//                                 child: Text(
//                                   workouts[i]["sets"][index],
//                                   style: TextStyle(
//                                     fontFamily: vr.basicFont,
//                                     fontSize: 18,
//                                     color: vr.orangeColor,
//                                   ),
//                                 )),
//                             title: Padding(
//                                 padding: EdgeInsetsDirectional.only(end: 10),
//                                 child: Text(
//                                   workouts[i]["workoutList"][index],
//                                   style: TextStyle(
//                                     fontFamily: vr.basicFont,
//                                     fontSize: 18,
//                                     color: vr.whiteColor,
//                                   ),
//                                 )),
//                           );
//                         }),
//                     Bounceable(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => CreateWorkoutScreen(),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 15),
//                         height: 40,
//                         child: Material(
//                           borderRadius: BorderRadius.circular(24),
//                           color: vr.orangeColor,
//                           elevation: 7,
//                           child: Center(
//                             child: Text(
//                               'START WORKOUT',
//                               style: TextStyle(
//                                 color: vr.whiteColor,
//                                 fontFamily: vr.basicFont,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }));
//   }
// }
