import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/models/user_model.dart';
import 'package:family_plus/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  late String _uid;
  late String _email;
  late UserModel _currentUser;

  String get getUid => _uid;
  UserModel get getCurrentUser => _currentUser;

  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retval = 'error';



    try{
      User? _firebaseUser = await _auth.currentUser;
      _currentUser.uid = _firebaseUser!.uid;
      _currentUser.email = _firebaseUser.email!;
      _uid = _firebaseUser!.uid;
      _email = _firebaseUser.email!;
      retval = 'succes';
    }catch(e){
      print(e);
    }

    return retval;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(String email, String password, String fullName) async {
    String retval = 'error';
    late UserModel _user;

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

       FirebaseFirestore.instance.collection("users").doc(_authResult.user!.uid).set({
        'fullName': fullName,
        'email': _authResult.user!.email,
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
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      _auth.signInWithCredential(credential);

      retval = 'succes';
    } on FirebaseAuthException catch (e) {
      retval = e.message!;
    }

    return retval;
  }


}
