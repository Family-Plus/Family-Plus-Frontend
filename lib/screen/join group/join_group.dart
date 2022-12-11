import 'package:family_plus/screen/home/home_screen.dart';
import 'package:family_plus/services/db_future.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({super.key});

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  void _joinGroup(BuildContext context, String groupId) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await DBFuture().joinGroup(groupId, uid);
    if (returnString == "success") {
      if(!mounted)return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => const HomeScreen()),
      );
    } else {
      if(!mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(returnString),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  final TextEditingController _groupIdController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _groupIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: const <Widget>[BackButton()],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _groupIdController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.group),
                    hintText: "Group Id",
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "Join",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _joinGroup(context, _groupIdController.text);
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}