// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hashtag_fitness/page/detailPage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

//Exercise database needs to be added
class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: Text('Exercise'),
        backgroundColor: Color(0xFF03111C),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            //color: Colors.black,
            onPressed: () => {},
          ),
          IconButton(
            icon: Icon(Icons.filter_alt),
            tooltip: 'Filter',
            //color: Colors.black,
            onPressed: () => {},
          ),
        ],
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Stream<QuerySnapshot> getExercises() {
    var firestore = FirebaseFirestore.instance;
    Stream<QuerySnapshot<Map<String, dynamic>>> qn =
        firestore.collection("exercises").snapshots(); //getDocuments()???
    return qn;
  }

  //Navigate to exercise details
  navigateToDetail(QueryDocumentSnapshot exercise) {
    //Following this youtube video
    // https://www.youtube.com/watch?v=AjAQglJKcb4&t=43s
    showModalBottomSheet(
        context: context,
        //isScrollControlled: true,
        builder: (context) => DetailPage(
              exercise: exercise,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: getExercises(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."), //Get animated loading screen
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot
                      .data!.docs.length, // getting length of exercise database
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8),

                      // decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: const [Color(0xFFFFE2C7), Color(0xFFFAF3E0)],
                      //   begin: Alignment.centerLeft,
                      //   end: Alignment.centerRight,
                      // ),
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(24),
                      //   ),
                      // ),
                      child: ListTile(
                        // -------- Format -----------
                        tileColor: const Color(0xFFF4F5F5),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),

                        // ------------ Format end -----------------
                        title: Text(snapshot.data!.docs[index]['name']),
                        //subtitle: Text(snapshot.data!.docs[index]["primaryMuscles"][0]),
                        subtitle: Text(
                            snapshot.data!.docs[index]["primaryMuscles"][0]),

                        onTap: () => navigateToDetail(snapshot
                            .data!.docs[index]), //Navigate to specific exercise
                      ),
                    );
                  });
            }
          }),
    );
  }
}
