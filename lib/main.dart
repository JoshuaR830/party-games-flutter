import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: Text('Games Library'),
        ),
        body: buildCard(context) // This creates the body of the page
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    return Center(
      child: generateGameCard(context, 'Pixenary', 'Can you guess what picture the pixel master is piecing together? The first person to work out what the picture is takes the victory - for now at least!'),
    );
  }

  Widget generateGameCard(BuildContext context, String gameName, String gameDescription) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Card(
        color: Colors.blueAccent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(gameName),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  gameDescription,
                  textAlign: TextAlign.center
              ),
            ),
            ButtonBar(
              children: [
                RaisedButton(
                  child: Text('play'),
                ),
              ],
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          side: BorderSide(
            color: Color(0xFF55EDBA),
            width: 1,
          ),
        ),
      ),
    );
  }
}