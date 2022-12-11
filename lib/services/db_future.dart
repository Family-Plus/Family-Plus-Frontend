import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DBFuture{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createGroup(
      String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = [];

    try {
      members.add(userUid);
      // tokens.add(user.notifToken);
      DocumentReference docRef;
        docRef = await _firestore.collection("groups").add({
          'name': groupName.trim(),
          'leader': userUid,
          'members': members,
          'groupCreated': Timestamp.now(),
        });


      await _firestore.collection("users").doc(userUid).update({
        'groupId': docRef.id,
      });

      //add a book
      retVal = "success";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = [];
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
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return retVal;
  }


}