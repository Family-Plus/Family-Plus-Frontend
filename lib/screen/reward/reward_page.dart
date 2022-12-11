import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/screen/reward/add_reward.dart';
import 'package:family_plus/widgets/reward_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RewardList extends StatefulWidget {
  const RewardList({Key? key}) : super(key: key);

  @override
  State<RewardList> createState() => _RewardListState();
}

class _RewardListState extends State<RewardList> {

  Stream<DocumentSnapshot> getUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  Stream<QuerySnapshot> getGroup(String uid) {
    if(uid == ""){
      return FirebaseFirestore.instance
          .collection("groups")
          .doc("uid")
          .collection("rewards")
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(uid)
        .collection("rewards")
        .snapshots();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Reward List",
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

                    Map<String, dynamic> document =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                    return InkWell(
                      onTap: () {

                      },
                      child: RewardCard(
                        id: snapshot.data!.docs[index].id,
                        title: document["title"] ?? "Judul Kosong",
                        value: document["number"],
                      ),
                    );
                  },
                );
              }
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => const AddReward()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
