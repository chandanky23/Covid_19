import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import '../models/countries.dart';
import '../models/country.dart';
import '../components/image_thumbnail.dart';

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

  // _getReportsFromCountries(countryData) async {
  //   String iso = countryData['iso'];
  //   String name = countryData['name'];
  //   var yesterday = new DateTime(now.year, now.month, now.day - 1);
  //   String formattedDate = dateFormatter.format(yesterday);
  //   var url =
  //       'https://covid-19-statistics.p.rapidapi.com/reports?iso=$iso&region_name=$name&date=$formattedDate';
  //   var response = await http.get(Uri.encodeFull(url), headers: headers);
  //   var data = json.decode(response.body);
  //   var rest = data['data'] as List;
  //   print(rest.length);
  // }

  Future<List<Country>> _getAllAffectedCountries() async {
    List<Country> list;
    var url = 'https://covid-19-be-flask.herokuapp.com/stats/all';
    var response = await http.get(
      Uri.encodeFull(url),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data['response'] as List;
      list = rest.map<Country>((json) => Country.fromJson(json)).toList();
    }
    return list;
  }

  Widget _listViewWidget(country) {
    return Container(
        child: ListView.builder(
            itemCount: country.length,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (BuildContext context, int position) {
              return Container(
                  height: 130,
                  margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20.0,
                          color: Colors.black26,
                          spreadRadius: 10.0)
                    ],
                    color: Colors.white,
                  ),
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20.0,
                              ),
                              ImageThumbnail('${country[position].flag}'),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                '${country[position].country}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          // Second row in each card
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'cases',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${country[position].cases.total}',
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'New',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'cases',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${country[position].cases.newcases != null ? country[position].cases.newcases : 0}',
                                    style: TextStyle(
                                        color: Colors.orange[700],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'deaths',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${country[position].deaths.total}',
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'New',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'deaths',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${country[position].deaths.newdeaths != null ? country[position].deaths.newdeaths : 0}',
                                    style: TextStyle(
                                        color: Colors.red[700],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Recovered',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'cases',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${country[position].cases.recovered}',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
            }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Covid 19 affected countries'),
        ),
        body: FutureBuilder(
          future: _getAllAffectedCountries(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? _listViewWidget(snapshot.data)
                : Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent),
                  );
          },
        ));
  }
}
