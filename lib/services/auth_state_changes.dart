import 'package:family_plus/screen/home/home_screen.dart';
import 'package:family_plus/screen/login/login_screen.dart';
import 'package:family_plus/screen/navigation/nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthChanges extends StatelessWidget {
  const AuthChanges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasData){
            return NavScreen();
          } else if(snapshot.hasError){
            return Center(child: Text("Has wrong"),);
          }else{
            return LoginScreen();
          }

        },
      ),
    );

  }
}
