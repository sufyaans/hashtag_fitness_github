import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hashtag_fitness/page/detailPage.dart';

//Exercise database needs to be added
class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
        backgroundColor: Colors.deepOrange,
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

  navigateToDetail(QueryDocumentSnapshot exercise) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  exercise: exercise,
                )));
    // DetailPage(
    //   exercise: exercise,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: getExercises(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot
                      .data!.docs.length, // getting length of exercise database
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 4.0),
                      height: 100,
                      child: ListTile(
                        // -------- Format -----------
                        tileColor: const Color(0xFFFFE2C7),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),

                        // ------------ Format end -----------------
                        title: Text(snapshot.data!.docs[index]['name']),
                        //subtitle: Text(snapshot.data!.docs[index]["primaryMuscles"][0]),
                        subtitle: Text(snapshot.data!.docs[index]["level"]),
                        //Outputting a tile with the exercise name  ["primaryMuscles"][0]
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
