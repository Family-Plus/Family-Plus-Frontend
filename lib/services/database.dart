import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/models/user_model.dart';

class OurDatabase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(UserModel user, String email) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        'fullName': user.fullName.trim(),
        'email': user.email.trim(),
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}