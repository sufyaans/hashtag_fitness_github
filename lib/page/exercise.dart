// ignore_for_file: prefer_const_constructors, dead_code
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hashtag_fitness/page/detailPage.dart';
import 'package:hashtag_fitness/variables.dart' as vr;

//Exercise database needs to be added
class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  bool searchState = false;

  Stream<QuerySnapshot> getExercises() {
    var firestore = FirebaseFirestore.instance;
    Stream<QuerySnapshot<Map<String, dynamic>>> qn =
        firestore.collection("exercises").snapshots();
    return qn;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getExercises(),
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: vr.backGround,
              appBar: AppBar(
                title: Text(
                  'Exercise',
                  style: TextStyle(fontFamily: vr.basicFont),
                ),
                backgroundColor: vr.backGround,
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    tooltip: 'Search',
                    onPressed: () {
                      if (!snapshot.hasData) {
                        return;
                      }
                      showSearch(
                          context: context,
                          delegate: ExerciceSearch(snapshot.data!));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_alt),
                    tooltip: 'Filter',
                    onPressed: () => {},
                  ),
                ],
              ),
              body: snapshot.hasData
                  ? ListPage(context: context, snapshot: snapshot.data!)
                  : SpinKitRing(color: vr.whiteColor, size: 50.0));
        });
  }
}

class ListPage extends StatelessWidget {
  final BuildContext context;
  final QuerySnapshot snapshot;
  const ListPage({Key? key, required this.context, required this.snapshot})
      : super(key: key);

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
    return ListView.builder(
        itemCount: snapshot.docs.length,
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
              title: Text(
                snapshot.docs[index]['name'],
                style: TextStyle(fontFamily: vr.basicFont),
              ),
              //subtitle: Text(snapshot.data!.docs[index]["primaryMuscles"][0]),
              subtitle: Text(
                snapshot.docs[index]["primaryMuscles"][0],
              ),

              onTap: () => navigateToDetail(
                  snapshot.docs[index]), //Navigate to specific exercise
            ),
          );
        });
  }
}

class ExerciceSearch extends SearchDelegate {
  QuerySnapshot exerices;
  ExerciceSearch(this.exerices);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(Icons.adaptive.arrow_back));

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return ThemeData(
  //     appBarTheme: const AppBarTheme(
  //       color: Color(0xFF03111C), // affects AppBar's background color
  //       //hintColy, // affects the initial 'Search' text
  //       textTheme: const TextTheme(
  //           headline6: TextStyle(
  //               // headline 6 affects the query text
  //               color: Colors.white,
  //               fontSize: 16.0,
  //               fontWeight: FontWeight.bold)),
  //     ),
  //   );
  // }

  @override
  Widget buildResults(BuildContext context) {
    var searchResult = exerices.docs.where((element) =>
        (element.get('name') as String)
            .toLowerCase()
            .contains(query.toLowerCase()));

    return searchResult.isEmpty
        ? Center(child: Text('Not found'))
        : ListView.builder(
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              var item = searchResult.elementAt(index);

              return ListTile(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => SafeArea(
                            child: DetailPage(
                              exercise: item,
                            ),
                          ));
                },
                tileColor: const Color(0xFFF4F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                title: Text(item['name']),
                subtitle: Text(item["primaryMuscles"][0]),
              );
            });
  }

  //adding searching suggestion
  @override
  Widget buildSuggestions(BuildContext context) {
    var searchResult = exerices.docs.toList();
    searchResult.shuffle();

    return true
        ? Center(
            child: Text('Type to search'),
          )
        : ListView.builder(
            itemCount: searchResult.length > 4 ? 4 : searchResult.length,
            itemBuilder: (context, index) {
              var item = searchResult.elementAt(index);
              return ListTile(
                tileColor: const Color(0xFFF4F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                title: Text(item['name']),
                subtitle: Text(item["primaryMuscles"][0]),
              );
            });
  }
}
