import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddReward extends StatefulWidget {
  const AddReward({Key? key}) : super(key: key);

  @override
  State<AddReward> createState() => _AddRewardState();
}

class _AddRewardState extends State<AddReward> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String type ="";
  String category = "";

  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient:
          LinearGradient(colors: [
            Color(0xff1d1e26),
            Color(0xff252041)]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              SizedBox(height: 30),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your Reward",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 25),
                    label("Reward Title"),
                    SizedBox(height: 12),
                    title(context),
                    SizedBox(height: 30),
                    label("Exp Requirement"),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        taskSelect("5000 Xp", 0xff2664fa, 5000),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelect("10000 Xp", 0xff2bc8d9, 10000),
                      ],
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      height: 50,
                    ),
                    button(context),
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
    return InkWell(
      onTap: (){
        FirebaseFirestore.instance.collection("reward").add({
          "title" : titleController.text, "number" : value
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Succes Add Reward"),
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
          child: Text("Add Reward",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget description(context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
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
      onTap: (){
        setState(() {
          type = label;
          value = number;
          print(number);
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: type == label ? Colors.black : Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.0),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: (){
        setState(() {
          category = label;
          print(category);
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: category == label ? Colors.black : Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
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
        controller: titleController,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Reward Title",
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
