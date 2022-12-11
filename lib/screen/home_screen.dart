import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/screen/create_group.dart';
import 'package:family_plus/screen/join_group.dart';
import 'package:family_plus/widgets/member_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool checkJoin = false;

  @override
  void didChangeDependencies() {
    showExpUser();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    isUserJoined();
    print(checkJoin);
  }

  Future<String> isJoin() async {
    String retVal = "error";
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();

      if (_docSnapshot.exists) {
        Map<String, dynamic> data =
            _docSnapshot.data()! as Map<String, dynamic>;

        if (data['groupId'] != "") {
          retVal = "succes";
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  isUserJoined() async {
    if (await isJoin() == "succes") {
      setState(() {
        checkJoin = true;
      });
    } else {
      checkJoin = false;
    }
  }

  String username = "";

  void showDisplayName() async {
    var collection = FirebaseFirestore.instance.collection('users');
    //userUid is the current auth user
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    var docSnapshot = await collection.doc(uid).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    username = data['fullName'];
  }

  String groupName = "";

  void showDisplayGroup() async {
    //userUid is the current auth user
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    var collectionUser = FirebaseFirestore.instance.collection('users');
    var docSnapshotUser = await collectionUser.doc(uid).get();
    Map<String, dynamic> dataUser = docSnapshotUser.data()!;
    String groupId = dataUser['groupId'];

    var collectionGroup = FirebaseFirestore.instance.collection('groups');
    var docSnapshot = await collectionGroup.doc(groupId).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    setState(() {
      groupName = data['name'];
    });
  }

  int anu = 0;

  void showExpUser() async {
    var collection = FirebaseFirestore.instance.collection('users');
    //userUid is the current auth user
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    var docSnapshot = await collection.doc(uid).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    setState(() {
      anu = data['exp'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showDisplayName();
    showDisplayGroup();
  }

  List<dynamic> member = [];

  void getListMember() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    var collectionUser = FirebaseFirestore.instance.collection('users');
    var docSnapshotUser = await collectionUser.doc(uid).get();
    Map<String, dynamic> dataUser = docSnapshotUser.data()!;
    String groupId = dataUser['groupId'];

    var collectionGroup = FirebaseFirestore.instance.collection('groups');
    var docSnapshot = await collectionGroup.doc(groupId).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    for (int i = 0; i < data["members"].length; i++) {
      member.add(data["members"]);
    }
  }

  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  Stream<DocumentSnapshot> getGroup(String uid) {
    return FirebaseFirestore.instance.collection('groups').doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 35,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 35,
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: provideDocumentFieldStream(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  Map<String, dynamic> documentFields =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        documentFields["exp"].toString() ?? "kosong",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //GREATING
                  Text(
                    "Hai $username",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //INFO BENNER
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 90,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 32),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFAD2D2),
                          Color(0xFFBCD4E6),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Nama Group : ${groupName ?? "Not In Group"}  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  //TITLE
                  Text(
                    checkJoin ? "List Family Member" : "Join or Create Group Here",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  checkJoin ? SizedBox(height: 10) : Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text(
                            "You haven't been in the family group",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  checkJoin
                      ? Container(
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: provideDocumentFieldStream(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                Map<String, dynamic> documentFields =
                                    snapshot.data!.data() as Map<String, dynamic>;
                                return Padding(
                                  padding: EdgeInsets.all(3),
                                  child: StreamBuilder<DocumentSnapshot>(
                                      stream: getGroup(documentFields["groupId"]),
                                      builder: (context, AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        Map<String, dynamic> documentFields =
                                            snapshot.data!.data()
                                                as Map<String, dynamic>;
                                        List<dynamic> coba =
                                            documentFields["members"];
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: coba.length,
                                          itemBuilder: (context, index) {
                                            return  MemberCard(id: coba[index],);
                                          },
                                        );
                                      }),
                                );
                              }),
                        )
                      : buildButton(context),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //CREATE GROUP
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => CreateGroup()),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2.3,
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFAD2D2),
                  Color(0xFFBCD4E6),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.group_add_outlined, size: 65),
                SizedBox(height: 16),
                Text(
                  "Create Group",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        //JOIN GROUP
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => JoinGroup()),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2.3,
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFAD2D2),
                  Color(0xFFBCD4E6),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.groups_outlined, size: 65),
                SizedBox(height: 16),
                Text(
                  "Join Group",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
