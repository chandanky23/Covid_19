import 'package:covid_19/components/spinner.dart';
import 'package:covid_19/models/world_data.dart';
import 'package:covid_19/services/ads.dart';
import 'package:covid_19/services/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:covid_19/components/world_data_list.dart';

class WorldData extends StatefulWidget {
  WorldData({Key key}) : super(key: key);
  @override
  WorldDataState createState() {
    return WorldDataState();
  }
}

class WorldDataState extends State<WorldData> {
  final dio = new Dio();

  // Firebase Analytics
  final AnalyticsService _analyticsService = AnalyticsService();

  World worldData;

  Future getGlobalData() async {
    List list = new List();
    var response =
        await dio.get('https://covid-19-be-flask.herokuapp.com/stats/global');
    if (response.statusCode == 200) {
      var data = response.data;
      List rest = data as List;
      list = rest.map<World>((json) => World.fromJson(json)).toList();
      setState(() {
        worldData = list[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getGlobalData();
    _analyticsService.getCurrentPage(
        page: 'Global Total Page', pageToOverride: 'WorldData');
    Ads.showBannerAd(this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Global Coronavirus Status'),
        ),
        body: Container(
          constraints:
              BoxConstraints.expand(height: MediaQuery.of(context).size.height),
          decoration: BoxDecoration(color: Colors.white),
          child: worldData != null
              ? worldDataList(context, worldData)
              : Container(child: Center(child: Spinner())),
        ));
  }
}
