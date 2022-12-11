import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {

  Stream<DocumentSnapshot> provideDocumentFieldStream(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> documentFields =
              snapshot.data!.data() as Map<String, dynamic>;
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
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.person,
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
                                  documentFields["fullName"] ?? "kosong",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${documentFields["exp"].toString()} Xp" ?? "kosong",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
        });
  }
}
