import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/countries.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  HomePageRoute createState() => HomePageRoute();
}

class HomePageRoute extends State<HomePage> {
  List _countries;
  final _listOfCountries = <List>[];


  Future<List<Countries>> _getAllAffectedCountries() async {
    List<Countries> list;
    var url = 'https://covid-19-statistics.p.rapidapi.com/regions';
    var headers = {
      'Accept': "application/json",
      'x-rapidapi-host': "covid-19-statistics.p.rapidapi.com",
      'x-rapidapi-key': "wQd4zoiDbhmshWKo1W2lkTeHl1VLp1XbXr4jsn8vmhWDcfmefr"
    };
    http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: headers
    );

    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data['data'] as List;
      list = rest.map<Countries>((json) => Countries.fromJson(json)).toList();
    }
    return list;
  }

  Widget _showCountriesList(countries) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, item) {
        if (item.isOdd) {
          return Divider();
        }
        return _showCountryInRow(countries[item ~/ 2]);
        // return null;
      },
    );
  }

  Widget _showCountryInRow(country) {
    return ListTile(
      title: Center(
        child: Text(country.name, style: TextStyle(fontSize: 18.0)),
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/country', arguments: country);
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid affected countries'),
      ),
      body: FutureBuilder(
        future: _getAllAffectedCountries(),
        builder: (context, snapshot) {
          return snapshot.data != null
            ? _showCountriesList(snapshot.data)
            : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.redAccent
              ),
            );
        },
      )
    );
  }
}