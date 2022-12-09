import 'package:family_plus/screen/create_group.dart';
import 'package:family_plus/screen/join_group.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0EFEB),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.account_circle,
            color: Colors.black,
            size: 35,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.black,
              size: 35,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                "0",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //GREATING
              const Text(
                "Hi Aldi!",
                style: TextStyle(
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
                child: const Center(
                  child: Text(
                    "You haven't make your plan for today",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              //TITLE
              const Text(
                "Today's Family Plan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    "You haven't been in the family group",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //CREATE GROUP
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => CreateGroup()
                        ),
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
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => JoinGroup()
                      ),
                    );},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
