// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hashtag_fitness/page/detailPage.dart';
import 'package:firestore_search/firestore_search.dart';

//Exercise database needs to be added
class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  Color orangeColor = Colors.deepOrange;
  String basicFont = 'roughMotion';
  bool searchState = false;

  @override
  Widget build(BuildContext context) {
/*
    return Scaffold(
      backgroundColor: Color(0xFF03111C),
      appBar: AppBar(
        title: !searchState
            ? Text(
                'Exercise',
                style: TextStyle(fontFamily: basicFont),
              )
            //Search field
            : TextField(
                onChanged: (value) {
                  // --------- Search function ----------
                },
                
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
        backgroundColor: Color(0xFF03111C),
        actions: [
          !searchState
              ? IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: () => {
                        //showSearch(context: context, delegate: exerciseSearch()),
                        setState(() {
                          searchState = !searchState;
                        })
                      })
              : IconButton(
                  icon: Icon(Icons.cancel),
                  tooltip: 'Cancel',
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                      //Navigator.of(context).pop();
                    });
                  },
                ),
          //Might not have to hide filter
          !searchState
              ? IconButton(
                  icon: Icon(Icons.filter_alt),
                  tooltip: 'Filter',
                  onPressed: () => {},
                )
              : IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.filter),
                  color: Colors.white.withOpacity(0),
                ),
        ],
      ),
      body: ListPage(),
    );
  }
*/

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
            onPressed: () =>
                {showSearch(context: context, delegate: exerciseSearch())},
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

// exerciseSearch with searchDelegate
class exerciseSearch extends SearchDelegate {
  var query = '';
  //List<DocumentSnapshot> exerciseList;
  Future<QuerySnapshot<Map<String, dynamic>>> exerciseList = FirebaseFirestore
      .instance
      .collection('exercises')
      .where('name', isGreaterThanOrEqualTo: query)
      .get();

  @override
  //Actions for the app bar
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  //Leading icon on the left of app bar
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  //Show results based on the selection
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var exercise in exerciseList) {
      if (exercise.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(exercise);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            // -------- Format -----------
            tileColor: const Color(0xFFF4F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),

            // ------------ Format end -----------------
            title: Text(snapshot.data!.docs[index]['name']),
            //subtitle: Text(snapshot.data!.docs[index]["primaryMuscles"][0]),
            subtitle: Text(snapshot.data!.docs[index]["primaryMuscles"][0]),

            onTap: () => navigateToDetail(
                snapshot.data!.docs[index]), //Navigate to specific exercise
          ),
        );
      },
    );
  }

  @override
  //Show when someone seaches for something
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var exercise in exerciseList) {
      if (exercise.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(exercise);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            // -------- Format -----------
            tileColor: const Color(0xFFF4F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),

            // ------------ Format end -----------------
            title: Text(snapshot.data!.docs[index]['name']),
            //subtitle: Text(snapshot.data!.docs[index]["primaryMuscles"][0]),
            subtitle: Text(snapshot.data!.docs[index]["primaryMuscles"][0]),

            onTap: () => navigateToDetail(
                snapshot.data!.docs[index]), //Navigate to specific exercise
          ),
        );
      },
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  //Gets exercise database
  Stream<QuerySnapshot> getExercises() {
    var firestore = FirebaseFirestore.instance;
    Stream<QuerySnapshot<Map<String, dynamic>>> qn =
        firestore.collection("exercises").snapshots(); //getDocuments()???
    return qn;
  }

  //Navigate to exercise details
  navigateToDetail(QueryDocumentSnapshot exercise) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SafeArea(
              child: DetailPage(
                exercise: exercise,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    const spinKit = SpinKitRing(
      color: Colors.white,
      size: 50.0,
    );

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: getExercises(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: spinKit, //Get animated loading screen
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot
                      .data!.docs.length, // getting length of exercise database
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8),
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
