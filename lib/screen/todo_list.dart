import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/screen/view_data.dart';
import 'package:family_plus/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
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
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.delete, color: Colors.red, size: 20),
          ),

        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                IconData iconData;
                Color iconColor;
                Map<String, dynamic> document =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

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

                selected.add(Select(id: snapshot.data!.docs[index].id, checkValue: false));
                
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ViewDataPage(
                          document: document,
                          id:  snapshot.data!.docs[index].id
                        ),
                      ),
                    );
                  },
                  child: TodoCard(
                    title: document["title"] == null
                        ? "Judul Kosong"
                        : document["title"],
                    check: selected[index].checkValue,
                    iconBgColor: Colors.white,
                    iconColor: iconColor,
                    iconData: iconData,
                    time:  document["number"].toString() == null
                        ? "No Xp"
                        : document["number"].toString(),
                    index: index,
                    onChange: onChange,
                    value: document["number"],
                  ),
                );
              },
            );
          }),
    );
  }

  void onChange(int index){
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }

}

class Select{
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}


