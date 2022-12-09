import 'package:family_plus/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
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
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TodoCard(
                  title: "Bangun Pagi",
                  check: true,
                  iconBgColor: Colors.white,
                  iconColor: Colors.red,
                  iconData: Icons.alarm,
                  time: "5 Am",
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
