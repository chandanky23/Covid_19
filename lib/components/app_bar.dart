import 'package:flutter/material.dart';

@override
Widget appBar(BuildContext context, Widget _appBarTitle, Icon _searchIcon, dynamic _searchPressed) {
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

