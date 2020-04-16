import './image_thumbnail.dart';
import 'package:flutter/material.dart';
import './empty_list.dart';

@override
Widget listViewWidget(country, handleCardTap) {
  return country.length == 0
      ? emptyList("Oops! no matching country found")
      : Container(
          child: ListView.builder(
              itemCount: country?.length,
              padding: const EdgeInsets.all(2.0),
              itemBuilder: (BuildContext context, int position) {
                return InkWell(
                  onTap: () {
                    handleCardTap(country[position]);
                  },
                  child: Container(
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
                                  ImageThumbnail(
                                      '${country[position].countryInfo.flag}'),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        '${country[position].cases}',
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
                                        '${country[position].todayCases}',
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
                                        '${country[position].deaths}',
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
                                        '${country[position].todayDeaths}',
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
                                        '${country[position].recovered}',
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
                      )),
                );
              }));
}
