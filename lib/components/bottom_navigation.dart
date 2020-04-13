import 'package:flutter/material.dart';

@override
Widget bottomNavigation(int _selectedIndex, _handleNavItemTap) {

  return new SingleChildScrollView(
      child: Container(
    decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black12),
        boxShadow: [BoxShadow(spreadRadius: 10.0, color: Colors.black12, offset: Offset(0.0, -10.0))]),
    child: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('World'))
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _handleNavItemTap,
    ),
  ));
}
