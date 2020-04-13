import 'package:flutter/material.dart';

@override
Widget bottomNavigation(int _selectedIndex, _handleNavItemTap) {
  return new BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
      BottomNavigationBarItem(
          icon: Icon(Icons.public), title: Text('World'))
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.amber[800],
    onTap: _handleNavItemTap,
  );
}
