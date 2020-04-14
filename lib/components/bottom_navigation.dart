import 'package:flutter/material.dart';

@override
Widget bottomNavigation(int _selectedIndex, _handleNavItemTap) {
  return new SingleChildScrollView(
      child: Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black12),
    ),
    child: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), title: Text('Dashboard')),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Global'))
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _handleNavItemTap,
    ),
  ));
}
