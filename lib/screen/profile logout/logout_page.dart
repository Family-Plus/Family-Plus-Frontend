import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/screen/history/reward_history.dart';
import 'package:family_plus/screen/history/todo_history.dart';
import 'package:family_plus/services/auth_state_changes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({Key? key}) : super(key: key);

  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  Stream<DocumentSnapshot> getUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff1d1e26), Color(0xff252041)]),
        ),
        child: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
              stream: getUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic> documentFields =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Hello ${documentFields["fullName"] ?? "No Name"}",
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                            ),
                          ),

                          const SizedBox(height: 33),
                          label("Full Name"),
                          const SizedBox(height: 12),
                          desc(documentFields["fullName"]),
                          const SizedBox(height: 25),
                          label("Email"),
                          const SizedBox(height: 12),
                          desc(documentFields["email"]),
                          const SizedBox(height: 25),
                          label("Current Exp"),
                          const SizedBox(height: 12),
                          desc(documentFields["exp"].toString()),
                          const SizedBox(height: 25),
                          label("Group Id"),
                          const SizedBox(height: 12),
                          buttonId(context, documentFields["groupId"]),
                          const SizedBox(height: 25),
                          label("History"),
                          const SizedBox(height: 12),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: buildHistoryTodo(context,
                                      Icons.task_rounded, "View Todo History"),
                                ),
                                buildDivider(),
                                Expanded(
                                  child: buildHistoryReward(
                                      context,
                                      Icons.wallet_giftcard_rounded,
                                      "View Reward History"),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          button(context),
                          const SizedBox(height: 30),
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
          .showSnackBar(const SnackBar(content: Text("Group Id Succes To Copy")));
    });
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();
      retVal = "success";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return retVal;
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          letterSpacing: 0.2),
    );
  }

  Widget desc(String label) {
    return Text(
      label,
      style: const TextStyle(
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
          gradient: const LinearGradient(
            colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ],
          ),
        ),
        child: Center(
          child: Text(id,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget button(context) {
    return InkWell(
      onTap: () async {
        String returnString = await signOut();
        if (returnString == "success") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => const AuthChanges()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(returnString),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ])),
        child: const Center(
          child: Text("LogOut",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget buildHistoryTodo(
      BuildContext context, IconData icons, String nameHistory) {
    return MaterialButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => const TodoHistory(),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icons, color: Colors.white),
          const SizedBox(height: 10),
          Text(nameHistory,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const SizedBox(
      height: 24,
      child: VerticalDivider(),
    );
  }

  Widget buildHistoryReward(
      BuildContext context, IconData icons, String nameHistory) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => RewardHistory(),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icons, color: Colors.white),
          SizedBox(height: 10),
          Text(nameHistory,
              textAlign: TextAlign.center,
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
        ],
      ),
    );
  }
}
