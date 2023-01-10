import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:full_project/screens/nav_screens/home_screen.dart';
import 'package:full_project/screens/nav_screens/profile_screen.dart';
import 'package:full_project/screens/nav_screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectIndex = 0;
  List<Widget> _widgetsList = [
    HomeScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // tilt
    // bearing
    // latitude
    // longitude

    return Scaffold(
      body: _widgetsList[selectIndex],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: 'Home'),
          TabItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: 'Profile'),
          TabItem(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: 'Setting'),
        ],
        initialActiveIndex: 0,
        onTap: updateIndex,
        backgroundColor: Color(0xff0b021c),
        activeColor: Color(0xff0b021c),
      ),
    );
  }

  void updateIndex(index) {
    setState(() {
      selectIndex = index;
    });
  }
}
