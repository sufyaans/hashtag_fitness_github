// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final QueryDocumentSnapshot? exercise;

  DetailPage({this.exercise});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise!["name"]),
          backgroundColor: Colors.deepOrange,
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
            child: Card(
          child: ListTile(
            title: Text(widget.exercise!["name"]),
            subtitle: Text(widget.exercise!["equipments"]),

            // Text(
            //     widget.exercise!["instructions"][0]), //Will add others later on
          ),
        )));
  }
}
