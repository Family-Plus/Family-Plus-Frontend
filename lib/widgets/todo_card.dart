import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  const TodoCard(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.iconColor,
      required this.time,
      required this.check,
      required this.iconBgColor,
      required this.onChange,
      required this.index, required this.value})
      : super(key: key);

  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Color iconBgColor;
  final Function onChange;
  final int index;
  final int value;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {


  void showDisplayName() async {
    int exp = 0;
    var collection = FirebaseFirestore.instance.collection('users');
    //userUid is the current auth user
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    var docSnapshot = await collection.doc(uid).get();

    Map<String, dynamic> data = docSnapshot.data()!;


    exp = data['exp'];
  }

  int exp = 0;
  @override
  Widget build(BuildContext context) {

    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;


    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
                primarySwatch: Colors.blue,
                unselectedWidgetColor: Color(0xff5e616a)),
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: Color(0xff6cf8a9),
                checkColor: Color(0xff0e3e26),
                value: widget.check,
                onChanged: (bool? value) async {
                  widget.onChange(widget.index);

                  var collection = FirebaseFirestore.instance.collection('users');
                  //userUid is the current auth user
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  String uid = _auth.currentUser!.uid;
                  var docSnapshot = await collection.doc(uid).get();
                  Map<String, dynamic> data = docSnapshot.data()!;

                  if(value == true){

                    exp = data['exp'] + widget.value;
                    print(exp);

                    FirebaseFirestore.instance.collection("users").doc(uid).update({
                      "exp" : exp,
                    });
                  }


                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Container(
                      height: 33,
                      width: 36,
                      decoration: BoxDecoration(
                        color: widget.iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        widget.iconData,
                        color: widget.iconColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "${widget.time} Xp",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
