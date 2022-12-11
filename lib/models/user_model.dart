import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String fullName;
  Timestamp accountCreated;
  String notifToken;

  UserModel(
      {required this.uid,
      required this.email,
      required this.fullName,
      required this.accountCreated,
      required this.notifToken});


}

