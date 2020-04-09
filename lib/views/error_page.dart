import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ERROR PAGE'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'OOPS! Where are you looking?',
                style: TextStyle(
                  fontSize: 18.0,
                  backgroundColor: Colors.red
                ),
              ),
              RaisedButton(
                child: Text('Go To Home Page'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
              )
            ],
          ),
        )
      );
  }
}