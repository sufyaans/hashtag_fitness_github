import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Future getExercises() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await firestore.collection("exercises").get(); //getDocuments()???
    return qn.docs; //qn.documents???
  }

  navigateToDetail(DocumentSnapshot exercise) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  exercise: exercise,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getExercises(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              ListView.builder(
                  itemCount: snapshot
                      .data.length, // getting length of exercise database
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].data[
                          "name"]), //Outputting a tile with the exercise name
                      onTap: () => navigateToDetail(
                          snapshot.data[index]), //Navigate to specific exercise
                    );
                  });
            }
          }),
    );
  }
}


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
