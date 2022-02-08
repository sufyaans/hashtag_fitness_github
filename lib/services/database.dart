import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String email, String password) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
    });
  }
}
