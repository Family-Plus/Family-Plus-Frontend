import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/widgets/reward_history_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RewardHistory extends StatefulWidget {
  const RewardHistory({Key? key}) : super(key: key);

  @override
  State<RewardHistory> createState() => _RewardHistoryState();
}

class _RewardHistoryState extends State<RewardHistory> {
  Stream<QuerySnapshot> getGroup(String uid) {
    if(uid == ""){
      return FirebaseFirestore.instance
          .collection("groups")
          .doc("uid")
          .collection("rewardHistory")
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(uid)
        .collection("rewardHistory")
        .snapshots();
  }

  Stream<DocumentSnapshot> getUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Reward History",
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
                      Map<String, dynamic> document = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;

                      return InkWell(
                        onTap: () {},
                        child: RewardHistoryCard(
                          title: document["title"] ?? "Judul Kosong",
                          clamiedBy: document["claimedBy"] ?? "Nama Kosong",
                          value: document["number"] ?? 0,
                        ),
                      );
                    },
                  );
                });
          }),
    );
  }
}
