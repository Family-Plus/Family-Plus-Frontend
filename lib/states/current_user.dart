import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  late String _uid;
  late String _email;
  late UserModel _currentUser;

  String get getUid => _uid;
  UserModel get getCurrentUser => _currentUser;

  String get getEmail => _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retval = 'error';



    try{
      User? firebaseUser = _auth.currentUser;
      _currentUser.uid = firebaseUser!.uid;
      _currentUser.email = firebaseUser.email!;
      _uid = firebaseUser.uid;
      _email = firebaseUser.email!;
      retval = 'succes';
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }

    return retval;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return retVal;
  }

  Future<String> signUpUser(String email, String password, String fullName) async {
    String retval = 'error';

    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

       FirebaseFirestore.instance.collection("users").doc(authResult.user!.uid).set({
        'fullName': fullName,
        'email': authResult.user!.email,
        'accountCreated': Timestamp.now(),
         'groupId' : "",
         'exp' : 0
      });

      retval = 'succes';
    } catch (e) {
      retval = e.toString();
    }

    return retval;
  }

  Future<String> loginWithEmail(String email, String password) async {
    String retval = 'error';

    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);

      retval = 'succes';
    } on FirebaseAuthException catch (e) {
      retval = e.message!;
    }

    return retval;
  }

  Future<String> loginWithGoogle() async {
    String retval = 'error';
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      _auth.signInWithCredential(credential);

      retval = 'succes';
    } on FirebaseAuthException catch (e) {
      retval = e.message!;
    }

    return retval;
  }


}
