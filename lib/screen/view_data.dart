import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewDataPage extends StatefulWidget {
  const ViewDataPage({Key? key, required this.document, required this.id})
      : super(key: key);

  final Map<String, dynamic> document;
  final String id;

  @override
  State<ViewDataPage> createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String type;
  late String category;
  bool isEdit = false;
  int value = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document["title"] == null
        ? "Judul Kosong"
        : widget.document["title"];
    titleController = TextEditingController(text: title);

    String description = widget.document["description"] == null
        ? "No Description"
        : widget.document["description"];
    descriptionController = TextEditingController(text: description);

    type = widget.document["task"] ?? "Important";
    category = widget.document["category"] ?? "Food";
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  ),
                  Row(
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                          stream: getUser(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            Map<String, dynamic> documentFields =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("groups")
                                    .doc(documentFields["groupId"])
                                    .collection("todo")
                                    .doc(widget.id)
                                    .delete()
                                    .then((value) => {Navigator.pop(context)});
                              },
                              icon: Icon(Icons.delete,
                                  color: Colors.red, size: 20),
                            );
                          }),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isEdit = !isEdit;
                          });
                        },
                        icon: Icon(Icons.edit_rounded,
                            color: isEdit ? Colors.green : Colors.white,
                            size: 20),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEdit ? "Editing" : "View",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your Todo",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 25),
                    label("Task Title"),
                    SizedBox(height: 12),
                    title(context),
                    SizedBox(height: 30),
                    label("Task Point"),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        taskSelect("250 Xp", 0xff2664fa, 250),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelect("500 Xp", 0xff2bc8d9, 500),
                      ],
                    ),
                    SizedBox(height: 25),
                    label("Description"),
                    SizedBox(height: 12),
                    description(context),
                    SizedBox(height: 25),
                    label("Category"),
                    SizedBox(height: 12),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categorySelect("Food", 0xffff6d6e),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Workout", 0xfff29732),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Work", 0xff6557ff),
                        SizedBox(
                          width: 10,
                        ),
                        categorySelect("Design", 0xff234ebd),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Run", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    isEdit ? button(context) : Container(),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button(context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: getUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> documentFields =
              snapshot.data!.data() as Map<String, dynamic>;

          return InkWell(
            onTap: () {
              // FirebaseFirestore.instance.collection("Todo").doc(widget.id).update({
              //   "title": titleController.text,
              //   "task": type,
              //   "category": category,
              //   "description": descriptionController.text,
              //   "number" : value
              // });

              FirebaseFirestore.instance
                  .collection("groups")
                  .doc(documentFields["groupId"])
                  .collection("todo")
                  .doc(widget.id)
                  .update({
                "title": titleController.text,
                "task": type,
                "category": category,
                "description": descriptionController.text,
                "number": value
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Succes Add Todo"),
                  duration: Duration(seconds: 2),
                ),
              );

              Navigator.pop(context);
            },
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
                child: Text("Update Todo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          );
        });
  }

  Widget description(context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        enabled: isEdit,
        controller: descriptionController,
        maxLines: null,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Description",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color, int number) {
    return InkWell(
      onTap: isEdit
          ? () {
              setState(() {
                type = label;
                value = number;
              });
            }
          : null,
      child: Chip(
        backgroundColor: type == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: type == label ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.0),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: isEdit
          ? () {
              setState(() {
                category = label;
                print(category);
              });
            }
          : null,
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: category == label ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.0),
      ),
    );
  }

  Widget title(context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        enabled: isEdit,
        controller: titleController,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2),
    );
  }
}
