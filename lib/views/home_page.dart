import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:covid_19/models/country.dart';
import 'package:covid_19/components/list_view.dart';
import 'package:covid_19/components/spinner.dart';
// import 'package:covid_19/components/empty_list.dart';
// import 'package:flutter/services.dart';

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

  void _getAllAffectedCountries() async {
    List list = new List();
    final response =
        await dio.get('https://covid-19-be-flask.herokuapp.com/stats/all');
    if (response.statusCode == 200) {
      var data = response.data;
      List rest = data as List;
      list = rest.map<Country>((json) => Country.fromJson(json)).toList();
    }
    setState(() {
      countryData = list;
      filteredCountryData = list;
    });
  }

  @override
  void initState() {
    this._getAllAffectedCountries();
    super.initState();
  }

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

  Widget _buildAppBar(BuildContext context) {
    return new AppBar(
      // centerTitle: true,
      title: _appBarTitle,
      // leading: new Icon(Icons.language),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
              child:
                  new IconButton(icon: _searchIcon, onPressed: _searchPressed)),
        ),
        // Padding(
        //   padding: EdgeInsets.only(right: 20.0),
        //   child: GestureDetector(child: Icon(Icons.sort)),
        // )
      ],
    );
  }

  Widget _filterList() {
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < countryData.length; i++) {
        if ('${countryData[i].country}'
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(countryData[i]);
        }
      }
      filteredCountryData = tempList;
    }
    return listViewWidget(filteredCountryData);
  }

  Future refreshApp() async {
    await Future.delayed(Duration(seconds: 2));
    _getAllAffectedCountries();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        child: Container(
            child: countryData.length != 0
                ? _filterList()
                : Container(child: Center(child: Spinner()))
        ),
        onRefresh: refreshApp,
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
