import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import '../models/countries.dart';
import '../models/country.dart';
import '../components/list_view.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  HomePageRoute createState() => HomePageRoute();
}

class HomePageRoute extends State<HomePage> {
  String currentDate;

  var headers = {
    'Accept': "application/json",
    'x-rapidapi-host': "covid-19-statistics.p.rapidapi.com",
    'x-rapidapi-key': "wQd4zoiDbhmshWKo1W2lkTeHl1VLp1XbXr4jsn8vmhWDcfmefr"
  };

  var now = new DateTime.now();
  var dateFormatter = new DateFormat('yyyy-MM-dd');

  String totalCasesLabel = 'Total cases:';

  Future<List<Country>> _getAllAffectedCountries() async {
    List<Country> list;
    var url = 'https://covid-19-be-flask.herokuapp.com/stats/all';
    var response = await http.get(
      Uri.encodeFull(url),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data as List;
      list = rest.map<Country>((json) => Country.fromJson(json)).toList();
    }
    return list;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Covid-19 Live Update'),
          leading: Icon(
            Icons.search
          ),
        ),
        body: FutureBuilder(
          future: _getAllAffectedCountries(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent),
                  );
          },
        ));
  }
}
