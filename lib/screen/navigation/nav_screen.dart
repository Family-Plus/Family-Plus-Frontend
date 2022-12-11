import 'package:family_plus/screen/todo/add_todo.dart';
import 'package:family_plus/screen/home/home_screen.dart';
import 'package:family_plus/screen/login/login_screen.dart';
import 'package:family_plus/screen/profile%20logout/logout_page.dart';
import 'package:family_plus/screen/reward/reward_page.dart';
import 'package:family_plus/screen/todo/todo_list.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/matescreen/rial.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  var _selectedIndex = 0;
  List<Widget> screens = const [HomeScreen(), LoginScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        screens: const [
          HomeScreen(),
          TodoList(),
          AddTodoPage(),
          RewardList(),
          LogOutPage(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home_outlined),
            activeColorPrimary: Colors.black,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.task_outlined),
            activeColorPrimary: Colors.black,
            inactiveColorPrimary: Colors.black26,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            activeColorPrimary: Colors.black,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.wallet_giftcard_outlined),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person_outlined),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
          ),
        ],
        navBarStyle: NavBarStyle.style17,
      ),
    );
  }
}
