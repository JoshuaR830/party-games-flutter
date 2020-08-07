import 'package:flutter/material.dart';
import 'package:party_games/Dialogs/Dialog.dart';

import '../LoginForm.dart';

class GameCard extends StatelessWidget {

  final String gameTitle;
  final String gameDescription;

  GameCard({
    @required this.gameTitle,
    @required this.gameDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              width: 1,
              color: Color(0xFF55EDBA),
            ),
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  this.gameTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  this.gameDescription,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center
              ),
            ),
            ButtonBar(
              children: [
                RaisedButton(
                    child: Text('play'),
                    color: Colors.deepPurple,
                    onPressed: () async {
                      print("Ah");
                      final result = await showDialog(
                          context: context, builder: (BuildContext context) => loginDialog);
                      Scaffold.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text(result)));
                    }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Something extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8f92c9),
      appBar: AppBar(
        title: Text('Games Library'),
      ),
      body: Center(
          child: ListView(
            children: <Widget>[ GameCard( gameTitle: 'Thoughts & Crosses',  gameDescription: "9 categories, 1 starting letter - mission: ensure each answer is unique to win big"), ]
          )
      ), // This creates the body of the page
    );
  }
}

class GamesLibraryPage extends StatelessWidget {
  Widget build(BuildContext context) {
//    final _cards = <Widget>[
//      generateGameCard(context, 'Pixenary', "Can you guess what picture the pixel master is piecing together? The first person to work out what the picture is takes the victory - for now at least!"),
//      generateGameCard(context, 'Balderdash', "Got Balderdash and find passing the paper around in secret nightmarish? Just a tree hugger and don't want to see more get the chop? - either way, don't worry, we've got you covered!"),
//      generateGameCard(context, 'Thoughts & Crosses', "9 categories, 1 starting letter - mission: ensure each answer is unique to win big"),
//      generateGameCard(context, 'The Word Game', "A bunch of random letters, a short amount of time - mission: come up with as many words as possible before you're out of time"),
//    ];

    return MaterialApp(
        title: 'Games Library',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Something()
      );
  }
}