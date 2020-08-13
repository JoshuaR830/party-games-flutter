import 'package:flutter/material.dart';

import '../main.dart';

class ConnectionErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connection Error',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF8f92c9),
        appBar: AppBar(
          title: Text("Connection Error"),
        ),
        body: Column(
        children: <Widget>[
          Center(
            child: Text("A connection error occurred"),
          ),
          RaisedButton(
            child: Text("Retry"),
            onPressed: () async {
              setupConnection();
            },
            color: Colors.deepPurple,
          ),
        ],
      ),
      ),
    );
  }
}
