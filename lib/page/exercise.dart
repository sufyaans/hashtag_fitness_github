import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hashtag_fitness/page/detail_page.dart';

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

<<<<<<< HEAD
  navigateToDetail(DocumentSnapshot exercise) {
=======
  navigateToDetail(QueryDocumentSnapshot exercise) {
>>>>>>> 4e9779ea965fe4edc5c0f997a9e6dfcddc566f06
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  exercise: exercise,
                )));
<<<<<<< HEAD
=======
    // DetailPage(
    //   exercise: exercise,
    // );
>>>>>>> 4e9779ea965fe4edc5c0f997a9e6dfcddc566f06
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
                    return ListTile(
<<<<<<< HEAD
                      title: Text(snapshot.data[index].data[
                          "name"]), //Outputting a tile with the exercise name
                      onTap: () => navigateToDetail(
                          snapshot.data[index]), //Navigate to specific exercise
=======
                      title: Text(snapshot.data!.docs[index]
                          ['name']), //Outputting a tile with the exercise name
                      onTap: () => navigateToDetail(snapshot
                          .data!.docs[index]), //Navigate to specific exercise
>>>>>>> 4e9779ea965fe4edc5c0f997a9e6dfcddc566f06
                    );
                  });
            }
          }),
    );
  }
}
<<<<<<< HEAD


class DetailPage extends StatefulWidget {
  final DocumentSnapshot exercise;

  DetailPage({this.exercise});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.exercise.data["name"]),),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.exercise.data["name"]),
            subtitle: Text(widget.exercise.data["instructions"]), //Will add others later on
      ),
    );
  }
}
=======
>>>>>>> 4e9779ea965fe4edc5c0f997a9e6dfcddc566f06
