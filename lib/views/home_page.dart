import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:covid_19/models/country.dart';
import 'package:covid_19/components/spinner.dart';
import 'package:covid_19/components/bottom_navigation.dart';
import 'package:covid_19/components/app_bar.dart';
import 'package:covid_19/components/search_filter.dart';
import 'package:covid_19/views/world_data.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  HomePageRoute createState() => HomePageRoute();
}

class HomePageRoute extends State<HomePage> {
  Widget _appBarTitle = new Text('Covid_19 Stats');
  Icon _searchIcon = new Icon(Icons.search);
  final TextEditingController _filter = new TextEditingController();
  List countryData = new List();
  String _searchText = "";
  List filteredCountryData = new List();
  final dio = new Dio();

  int _selectedBottomNavigationIndex = 0;
  bool _isBottomNavBarVisible = false;
  ScrollController _hideBottomNavBarController = new ScrollController();

  // __init__ method
  @override
  void initState() {
    this._getAllAffectedCountries();
    super.initState();
    this._handleBottomNavVisibilityOnScroll();
  }

  // Method to get data from api
  void _getAllAffectedCountries() async {
    List list = new List();
    final response =
        await dio.get('https://covid-19-be-flask.herokuapp.com/stats/all');
    var data = response.data;
    List rest = data as List;
    list = rest.map<Country>((json) => Country.fromJson(json)).toList();
    setState(() {
      countryData = list;
      filteredCountryData = list;
    });
  }

  // Method to handle search in a list to filter data
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          cursorColor: Colors.white,
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Country names...',
              hintStyle: new TextStyle(
                color: Colors.white54,
              ),
              border: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white))),
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Covid_19 Stats');
        filteredCountryData = countryData;
        _filter.clear();
      }
    });
  }

  // Handle bottom navigation switch
  void _handleBottomNavigation(int index) {
    setState(() {
      _selectedBottomNavigationIndex = index;
    });
  }

  // Handle bottom navbar visibility on scroll
  void _handleBottomNavVisibilityOnScroll() async {
    _isBottomNavBarVisible = true;
    _hideBottomNavBarController = new ScrollController();
    _hideBottomNavBarController.addListener(() {
      if (_hideBottomNavBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isBottomNavBarVisible == true) {
          // onlye set when previous state is true
          setState(() {
            _isBottomNavBarVisible = false;
          });
        }
      } else {
        if (_hideBottomNavBarController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isBottomNavBarVisible == false) {
            // onlye set when previous state is false
            setState(() {
              _isBottomNavBarVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _hideBottomNavBarController.removeListener(() {});
    super.dispose();
  }

  HomePageRoute() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredCountryData = countryData;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Future refreshApp() async {
    await Future.delayed(Duration(seconds: 2));
    _getAllAffectedCountries();
  }

  Widget handlePageSwitch() {
    switch (_selectedBottomNavigationIndex) {
      case 0:
        return countryDashBoard();
      case 1:
        return WorldData();
      default:
        return countryDashBoard();
    }
  }

  Widget handleAppBarSwitch() {
    switch (_selectedBottomNavigationIndex) {
      case 0:
        return appBar(context, _appBarTitle, _searchIcon, _searchPressed);
      case 1:
        return AppBar(
          title: Text('Global Status'),
        );
      default:
        return appBar(context, _appBarTitle, _searchIcon, _searchPressed);
    }
  }

  Widget countryDashBoard() {
    return new RefreshIndicator(
      child: Container(
          child: countryData.length != 0
              ? filterOnSearch(_searchText, countryData, filteredCountryData,
                  _hideBottomNavBarController)
              : Container(child: Center(child: Spinner()))),
      onRefresh: refreshApp,
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: handleAppBarSwitch(),
      body: handlePageSwitch(),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: _isBottomNavBarVisible ? 58.0 : 0.0,
        child: _isBottomNavBarVisible
            ? bottomNavigation(
                _selectedBottomNavigationIndex, _handleBottomNavigation)
            : Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
              ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
