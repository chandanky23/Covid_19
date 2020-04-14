import 'package:flutter/material.dart';
import 'package:covid_19/components/bottom_navigation.dart';
import './home_page.dart';
import './world_data.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}): super(key: key);
  @override
  DashboardSate createState() {
    return DashboardSate();
  }
}

class DashboardSate extends State<Dashboard> {

  int _selectedBottomNavigationIndex = 0;
  List _children = [
    WorldDashboard(),
    WorldData()
  ];

  // Handle bottom navigation switch
  void _handleBottomNavigation(int index) {
    setState(() {
      _selectedBottomNavigationIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_selectedBottomNavigationIndex],
      bottomNavigationBar: bottomNavigation(
          _selectedBottomNavigationIndex, _handleBottomNavigation),
    );
  }
}
