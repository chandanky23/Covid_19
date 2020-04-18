import 'package:covid_19/route_generator.dart';
import 'package:covid_19/services/firebase_analytics.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:covid_19/models/country.dart';
import 'package:covid_19/components/spinner.dart';
import 'package:covid_19/components/app_bar.dart';
import 'package:covid_19/components/search_filter_country.dart';
import 'package:flutter/rendering.dart';

class WorldDashboard extends StatefulWidget {
  WorldDashboard({Key key}) : super(key: key);
  @override
  WorldDashboardRoute createState() => WorldDashboardRoute();
}

class WorldDashboardRoute extends State<WorldDashboard> {
  Widget _appBarTitle =
      new Text('Latest Coronavirus Status', style: TextStyle(fontSize: 18.0));
  Icon _searchIcon = new Icon(Icons.search);
  final TextEditingController _filter = new TextEditingController();
  List countryData = new List();
  String _searchText = "";
  List filteredCountryData = new List();
  final dio = new Dio();
  bool _spinner = true;
  String _error = '';

  // Firebase Analytics
  final AnalyticsService _analyticsService = AnalyticsService();

  // __init__ method
  @override
  void initState() {
    this._getAllAffectedCountries();
    super.initState();
    _analyticsService.getCurrentPage(
        page: 'Landing page (world wide current data)',
        pageToOverride: 'WorldDashboard');
  }

  // Method to get data from api
  void _getAllAffectedCountries() async {
    List list = new List();
    try {
      final response = await dio.get(
          'https://covid-19-be-flask.herokuapp.com/stats/all',
          queryParameters: {"sort": "cases", "yesterday": false});
      if (response.statusCode == 200) {
        var data = response.data;
        List rest = data as List;
        list = rest.map<Country>((json) => Country.fromJson(json)).toList();
      }
      setState(() {
        countryData = list;
        filteredCountryData = list;
        _spinner = false;
        _error = '';
      });
    } catch (e) {
      if (e is DioError) {
        _spinner = false;
        _error = 'Something happened. Please reload.';
      } else {
        setState(() {
          _error = 'Server is down. Please try after sometime';
          _spinner = false;
        });
      }
    }
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
        this._appBarTitle = new Text(
          'Latest Coronavirus Status',
          style: TextStyle(fontSize: 18.0),
        );
        filteredCountryData = countryData;
        _filter.clear();
      }
    });
  }

  void handleCardTap(data) {
    Navigator.pushNamed(context, '/country',
        arguments: ScreenArguments(
            country: data.country,
            iso: data.countryInfo.iso2,
            flag: data.countryInfo.flag));
  }

  WorldDashboardRoute() {
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

  Widget countryDashBoard() {
    if (_spinner) {
      return Container(child: Center(child: Spinner()));
    }
    if (_error != '') {
      return Container(
          child: Center(
              child: Column(
        children: <Widget>[
          Text(
            _error,
            style: TextStyle(color: Colors.red),
          )
        ],
      )));
    }
    return new RefreshIndicator(
      child: Container(
          child: countryData.length != 0
              ? filterOnSearch(
                  _searchText, countryData, filteredCountryData, handleCardTap)
              : Text(
                  'No data found',
                  style: TextStyle(color: Colors.red),
                )),
      onRefresh: refreshApp,
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: appBar(context, _appBarTitle, _searchIcon, _searchPressed),
        body: countryDashBoard());
  }
}
