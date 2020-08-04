import 'package:flutter/material.dart';

import 'Pages/GamesLibraryPage.dart';

void main() => runApp(PartyGames());

class PartyGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games Library',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF8f92c9),
        appBar: AppBar(
          title: Text('Games Library'),
        ),
        body: GamesLibraryPage() // This creates the body of the page
      ),
    );
  }
}