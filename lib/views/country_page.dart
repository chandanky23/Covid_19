import 'package:covid_19/components/image_thumbnail.dart';
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

  // __init__ method
  @override
  void initState() {
    print(widget);
    this._getAffectedCountryData();
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
      queryParameters: {'country': widget.country}
    );
    if (response.statusCode == 200) {
      var data = response.data;
      List rest = data as List;
      list = rest.map<Province>((json) => Province.fromJson(json)).toList();
    }
    setState(() {
      provineData = list;
      filteredprovineData = list;
    });
  }

  void _getStatsOfCountry() async {
    List list = new List();
    final response = await dio.get(
      'https://covid-19-be-flask.herokuapp.com/stats/country/history',
      queryParameters: {'country': widget.country}
    );
    // if(response.statusCode == 200) {
    //   List data = response.data as List;
    //   list = rest.map<>
    // }
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

  void handleCardTap(data) {
    // if(data.toLowerCase() == 'india') {
    //   print(data);
    // }
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
    return new RefreshIndicator(
      child: Container(
          child: provineData.length != 0
              ? filterOnSearch(_searchText, provineData, filteredprovineData)
              : Container(child: Center(child: Spinner()))),
      onRefresh: refreshApp,
    );
  }

  void _showBottomStatsSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            color: Colors.black,
            child: new Center(
              child: Text('heelo'),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar(context, _appBarTitle, _searchIcon, _searchPressed),
      body: countryDashBoard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomStatsSheet();
        },
        child: new Text('Stats'),
        backgroundColor: Colors.black,
      ),
    );
  }
}
