import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/screen/todo/view_data.dart';
import 'package:family_plus/widgets/todo_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  Stream<QuerySnapshot> getGroup(String uid) {
    if(uid == ""){
      return FirebaseFirestore.instance
          .collection("groups")
          .doc("uid")
          .collection("todo")
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(uid)
        .collection("todo")
        .snapshots();
  }

  Stream<DocumentSnapshot> getUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Todo List",
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
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> documentFields =
                snapshot.data!.data() as Map<String, dynamic>;

            return StreamBuilder<QuerySnapshot>(
                stream: getGroup(documentFields["groupId"]),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      IconData iconData;
                      Color iconColor;
                      Map<String, dynamic> document = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      switch (document["category"]) {
                        case "Work":
                          iconData = Icons.sports_handball_outlined;
                          iconColor = Colors.red;
                          break;
                        case "Workout":
                          iconData = Icons.people_alt_outlined;
                          iconColor = Colors.blue;
                          break;
                        case "Food":
                          iconData = Icons.fastfood_outlined;
                          iconColor = Colors.green;
                          break;
                        case "Design":
                          iconData = Icons.design_services_outlined;
                          iconColor = Colors.teal;
                          break;
                        case "Run":
                          iconData = Icons.run_circle_outlined;
                          iconColor = Colors.yellowAccent;
                          break;
                        default:
                          iconData = Icons.run_circle_outlined;
                          iconColor = Colors.red;
                      }

                      selected.add(Select(
                          id: snapshot.data!.docs[index].id,
                          checkValue: document["checkValue"] ?? false));

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => ViewDataPage(
                                  document: document,
                                  id: snapshot.data!.docs[index].id),
                            ),
                          );
                        },
                        child: TodoCard(
                          id: snapshot.data!.docs[index].id,
                          title: document["title"] ?? "Judul Kosong",
                          check:  document["checkValue"],
                          iconBgColor: Colors.white,
                          iconColor: iconColor,
                          iconData: iconData,
                          time: document["number"].toString(),
                          index: index,
                          onChange: onChange,
                          value: document["number"],
                        ),
                      );
                    },
                  );
                });
          }),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  String id;
  bool checkValue = false;

  Select({required this.id, required this.checkValue});
}
