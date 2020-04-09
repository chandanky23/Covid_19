import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model
import '../models/province.dart';

// Named imports
import '../models/countries.dart';

class CountryPage extends StatefulWidget {
  final Countries data;
  
  CountryPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  CountryPageRoute createState() => CountryPageRoute();
}

class CountryPageRoute extends State<CountryPage> {
  final _listOfProvinces = <List>[];


  Future _getAllAffectedProvinces(Countries data) async {
    List<Province> list;

    String uri = 'https://covid-19-statistics.p.rapidapi.com/provinces?iso=${data.iso}';

    http.Response response = await http.get(
      Uri.encodeFull(uri),
      headers: {
        'x-rapidapi-host': "covid-19-statistics.p.rapidapi.com",
        'x-rapidapi-key': "wQd4zoiDbhmshWKo1W2lkTeHl1VLp1XbXr4jsn8vmhWDcfmefr",
        'Accept': 'application/json'
      }
    );
    var dataLength = response.body;
    print(dataLength);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data['data'] as List;
      list = rest.map<Province>((json) => Province.fromJson(json)).toList();
    }
    return list;
  }

  Widget _listViewWidget(province) {
    return Container(
      child: ListView.builder(
        itemCount: province.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (BuildContext context, int position) {
          return Card(
            child: ListTile(
              title: Text(
                '${province[position].province}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.purple[900],
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country'),
      ),
      body: FutureBuilder(
        future: _getAllAffectedProvinces(widget.data),
        builder: (context, snapshot) {
          return snapshot.data != null
            ? _listViewWidget(snapshot.data)
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