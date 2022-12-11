import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RewardCard extends StatefulWidget {
  const RewardCard({Key? key, required this.title, required this.value, required this.id})
      : super(key: key);
  final String title;
  final int value;
  final String id;

  @override
  State<RewardCard> createState() => _RewardCardState();
}

class _RewardCardState extends State<RewardCard> {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Stream<DocumentSnapshot> getUser() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Container(
                      height: 43,
                      width: 46,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.money,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Min: ${widget.value.toString()} Xp",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: getUser(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            Map<String, dynamic> documentFields =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return ElevatedButton(
                              onPressed: documentFields["exp"] >= widget.value
                                  ? () {
                                      if (documentFields["exp"] >=
                                          widget.value) {

                                        String uid = _auth.currentUser!.uid;

                                        FirebaseFirestore.instance.collection("users").doc(uid).update({
                                          "exp" : documentFields["exp"] - widget.value,
                                        });

                                        FirebaseFirestore.instance
                                            .collection("groups")
                                            .doc(documentFields["groupId"])
                                            .collection("rewardHistory")
                                            .add({
                                          "title": widget.title,
                                          "claimedBy": documentFields["fullName"],
                                          "number": widget.value
                                        });

                                        FirebaseFirestore.instance
                                            .collection("groups")
                                            .doc(documentFields["groupId"])
                                            .collection("rewards")
                                            .doc(widget.id)
                                            .delete()
                                            .then((value) => {print("Todo Deleted")});

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Succes Claim"),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Point Tidak Cukup"),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    }
                                  : null,
                              child: Text("Claim", style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      width: 30,
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
