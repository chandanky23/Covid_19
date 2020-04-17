import 'package:covid_19/components/country_stats.dart';
import 'package:covid_19/components/image_thumbnail.dart';
import 'package:covid_19/models/country_stats.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:covid_19/models/province.dart';
import 'package:covid_19/components/spinner.dart';
import 'package:covid_19/components/app_bar.dart';
import 'package:covid_19/components/search_filter_province.dart';
import 'package:flutter/rendering.dart';

class CountryDashboard extends StatefulWidget {
  final String country;
  final String iso;
  final String flag;
  CountryDashboard(
      {Key key,
      @required this.country,
      @required this.iso,
      @required this.flag})
      : super(key: key);
  @override
  CountryDashboardRoute createState() => CountryDashboardRoute();
}

class CountryDashboardRoute extends State<CountryDashboard> {
  Widget _appBarTitle;
  Icon _searchIcon = new Icon(Icons.search);
  final TextEditingController _filter = new TextEditingController();
  List provineData = new List();
  String _searchText = "";
  List filteredprovineData = new List();
  final dio = new Dio();
  bool _showSpinner = false;

  List activeStatsData = new List();
  List criticalStatsData = new List();
  List deathsStatsData = new List();
  List newDeathsStatsData = new List();
  List newCasesStatsData = new List();
  List recoveredStatsData = new List();
  List totalStatsData = new List();

  // __init__ method
  @override
  void initState() {
    this._getAffectedCountryData();
    this._getStatsOfCountry();
    setState(() {
      _showSpinner = true;
    });
    super.initState();
    this._appBarTitle = Row(
      children: <Widget>[
        ImageThumbnail(widget.flag),
        SizedBox(width: 20.0),
        Text(widget.country)
      ],
    );
  }

  // Method to get data from api
  void _getAffectedCountryData() async {
    List list = new List();
    final response = await dio.get(
        'https://covid-19-be-flask.herokuapp.com/stats/country/data',
        queryParameters: {'country': widget.country});
    if (response.statusCode == 200) {
      var data = response.data;
      List rest = data as List;
      list = rest.map<Province>((json) => Province.fromJson(json)).toList();
      setState(() {
        provineData = list;
        filteredprovineData = list;
        _showSpinner = false;
      });
    }
  }

  void _getStatsOfCountry() async {
    List activeList = new List();
    List criticalList = new List();
    List deathsList = new List();
    List newDeathsList = new List();
    List newCasesList = new List();
    List recoveredList = new List();
    List totalList = new List();
    final response = await dio.get(
        'https://covid-19-be-flask.herokuapp.com/stats/country/history',
        queryParameters: {'country': widget.country});
    if (response.statusCode == 200) {
      // List data = response.data as List;
      // list = data.map<CountryStats>((json) => CountryStats.fromJson(json)).toList();
      var data = response.data;
      for (int i = 0; i < data.length; i++) {
        if (data[i] == 'active') {
          activeList = data[i]
              .map<CountryStats>((json) => CountryStats.fromJson(json))
              .toList();
        }
        if (data[i] == 'critical') {
          criticalList = data[i]
              .map<CountryStats>((json) => CountryStats.fromJson(json))
              .toList();
        }
        if (data[i] == 'deaths') {
          deathsList = data[i]
              .map<CountryStats>((json) => CountryStats.fromJson(json))
              .toList();
        }
        if (data[i] == 'newDeaths') {
          newDeathsList = data[i]
              .map<CountryStats>((json) => CountryStats.fromJson(json))
              .toList();
        }
        if (data[i] == 'newCases') {
          newCasesList = data[i]
              .map<CountryStats>((json) => CountryStats.fromJson(json))
              .toList();
        }
        if (data[i] == 'recovered') {
          recoveredList = data[i]
              .map<CountryStats>((json) => CountryStats.fromJson(json))
              .toList();
        }
        if (data[i] == 'total') {
          totalList = data[i]
              .map<CountryStats>((json) => CountryStats.fromJson(json))
              .toList();
        }
      }
    }
    setState(() {
      activeStatsData = activeList;
      criticalStatsData = criticalList;
      newDeathsStatsData = newDeathsList;
      newCasesList = newCasesList;
      deathsStatsData = deathsList;
      recoveredStatsData = recoveredList;
      totalStatsData = totalList;
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
        this._appBarTitle = new Row(
          children: <Widget>[
            ImageThumbnail(widget.flag),
            SizedBox(width: 20.0),
            Text(widget.country)
          ],
        );
        filteredprovineData = provineData;
        _filter.clear();
      }
    });
  }

  CountryDashboardRoute() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredprovineData = provineData;
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
    _getAffectedCountryData();
    _getStatsOfCountry();
  }

  Widget countryDashBoard() {
    if (_showSpinner) {
      return Container(child: Center(child: Spinner()));
    } else {
      return new RefreshIndicator(
        child: Container(
            child: provineData.length > 0
                ? filterOnSearch(_searchText, provineData, filteredprovineData)
                : countryStats(context, Axis.vertical,
                    MediaQuery.of(context).size.height, activeStatsData)),
        onRefresh: refreshApp,
      );
    }
  }

  void _showBottomStatsSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Statistics',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  countryStats(context, Axis.horizontal,
                      MediaQuery.of(context).size.height * .4, activeStatsData)
                ],
              ));
        });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: provineData.length > 0
            ? appBar(context, _appBarTitle, _searchIcon, _searchPressed)
            : AppBar(
                title: _appBarTitle,
              ),
        body: countryDashBoard(),
        floatingActionButton: provineData.length > 0
            ? FloatingActionButton(
                onPressed: () {
                  _showBottomStatsSheet();
                },
                child: new Text('Stats'),
                backgroundColor: Colors.black,
              )
            : null);
  }
}
