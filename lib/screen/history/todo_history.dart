import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/widgets/todo_history_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TodoHistory extends StatefulWidget {
  const TodoHistory({Key? key}) : super(key: key);

  @override
  State<TodoHistory> createState() => _TodoHistoryState();
}

class _TodoHistoryState extends State<TodoHistory> {
  Stream<QuerySnapshot> getGroup(String uid) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(uid)
        .collection("todoHistory")
        .snapshots();
  }

  Stream<DocumentSnapshot> getUser() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  Stream<QuerySnapshot> _stream =
  FirebaseFirestore.instance.collection("Todo").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Todo History",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: getUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> documentFields =
            snapshot.data!.data() as Map<String, dynamic>;

            return StreamBuilder<QuerySnapshot>(
                stream: getGroup(documentFields["groupId"]),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> document = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;


                      return InkWell(
                        onTap: () {

                        },
                        child: TodoHistoryCard(
                          title: document["title"] == null
                              ? "Judul Kosong"
                              : document["title"],
                          completedBy: document["completedBy"] == null
                              ? "Nama Kosong"
                              : document["completedBy"],
                          value: document["number"],
                        ),
                      );
                    },
                  );
                });
          }),
    );
  }
}
