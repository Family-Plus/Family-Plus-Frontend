import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/screen/add_reward.dart';
import 'package:family_plus/widgets/reward_card.dart';
import 'package:flutter/material.dart';

class RewardList extends StatefulWidget {
  const RewardList({Key? key}) : super(key: key);

  @override
  State<RewardList> createState() => _RewardListState();
}

class _RewardListState extends State<RewardList> {
  final Stream<QuerySnapshot> _stream =
  FirebaseFirestore.instance.collection("reward").snapshots();


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
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
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
                    title: document["title"] == null
                        ? "Judul Kosong"
                        : document["title"],
                    value: document["number"],
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => AddReward()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
