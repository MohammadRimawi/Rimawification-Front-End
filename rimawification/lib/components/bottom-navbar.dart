import 'package:flutter/material.dart';
import 'package:rimawification/pages/home/home.dart';
import 'package:rimawification/pages/subscriptions/subscriptions.dart';
import 'package:rimawification/pages/todo/task-page.dart';
import 'package:rimawification/pages/todo/tasks-page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[TasksPage(), Home(), subscriptionsPage()];
    final _navItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.auto_awesome_sharp), label: "Tasks"),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.backpack), label: "hello"),
    ];
    final bottomNavBar = BottomNavigationBar(
      items: _navItems,
      currentIndex: _currentPageIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
    );

    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
