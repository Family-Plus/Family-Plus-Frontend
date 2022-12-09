
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/models/user_model.dart';
import 'package:flutter/services.dart';

class DBFuture{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createGroup(
      String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = [];
    List<String> tokens = [];

    try {
      members.add(userUid);
      // tokens.add(user.notifToken);
      DocumentReference _docRef;
        _docRef = await _firestore.collection("groups").add({
          'name': groupName.trim(),
          'leader': userUid,
          'members': members,
          'groupCreated': Timestamp.now(),
        });


      await _firestore.collection("users").doc(userUid).update({
        'groupId': _docRef.id,
      });

      //add a book
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = [];
    List<String> tokens = [];
    try {
      members.add(userUid);
      // tokens.add(userModel.notifToken);
      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });

      await _firestore.collection("users").doc(userUid).update({
        'groupId': groupId.trim(),
      });

      retVal = "success";
    } on PlatformException catch (e) {
      retVal = "Make sure you have the right group ID!";
      print(e);
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}