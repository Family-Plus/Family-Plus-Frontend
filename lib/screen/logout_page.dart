import 'package:family_plus/screen/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            String returnString = await signOut();

            if(returnString == "success"){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => LoginScreen()
                ),
              );
            }

          },
          child: Text("Log Out"),
        ),
      ),
    );
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
