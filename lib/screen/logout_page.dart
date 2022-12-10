import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/screen/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({Key? key}) : super(key: key);

  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  Stream<DocumentSnapshot> getUser() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff1d1e26), Color(0xff252041)]),
        ),
        child: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
              stream: getUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic> documentFields =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Hello ${documentFields["fullName"] ?? "No Name"}",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                            ),
                          ),
                          SizedBox(height: 8),
                          SizedBox(height: 25),
                          label("Full Name"),
                          SizedBox(height: 12),
                          desc(documentFields["fullName"]),
                          SizedBox(height: 25),
                          label("Email"),
                          SizedBox(height: 12),
                          desc(documentFields["email"]),
                          SizedBox(height: 25),
                          label("Current Exp"),
                          SizedBox(height: 12),
                          desc(documentFields["exp"].toString()),
                          SizedBox(height: 25),
                          label("Group Id"),
                          SizedBox(height: 12),
                          buttonId(context, documentFields["groupId"]),
                          SizedBox(
                            height: 50,
                          ),
                          button(context),
                          SizedBox(height: 30),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _copyGroupId(BuildContext context, String id) {
    Clipboard.setData(ClipboardData(text: id)).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Group Id Succes To Copy")));
    });
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

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          letterSpacing: 0.2),
    );
  }

  Widget desc(String label) {
    return Text(
      label,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          letterSpacing: 0.2),
    );
  }

  Widget buttonId(context, id) {
    return InkWell(
      onTap: () => _copyGroupId(context, id),
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Color(0xff8a32f1),
              Color(0xff8ad32f9),
            ],
          ),
        ),
        child: Center(
          child: Text(id,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget button(context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xff8a32f1),
              Color(0xff8ad32f9),
            ])),
        child: Center(
          child: Text("LogOut",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
