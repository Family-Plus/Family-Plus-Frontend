import 'package:family_plus/screen/home/home_screen.dart';
import 'package:family_plus/services/db_future.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});



  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  void _createGroup(BuildContext context, String groupName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await DBFuture().createGroup(groupName, uid);
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


  final TextEditingController _groupNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _groupNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: _groupNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.group),
                    hintText: "Group Name",
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: Text(
                      "Add Group",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _createGroup(context, _groupNameController.text);
                  }
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