import 'package:flutter/material.dart';

import '../main.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

  var roundScoreList = <Widget>[];

  Map<String, dynamic> allScores;

  void _doThis(scores) {
    if(!mounted) return;
    setState(() {
      allScores = scores;

      var users = allScores.keys;
      var something = allScores["joshua"].length;

      roundScoreList.clear();
      for(var i = 0; i < something; i++) {
        print("Round ${i+1}");
        roundScoreList.add(Text("Round ${i+1}"),);
        users.forEach((user) {
          print(user[0].toUpperCase() + user.substring(1));

          roundScoreList.add(Text("${user[0].toUpperCase() + user.substring(1)}: ${(allScores[user][i].length > i ? allScores[user][i] : 0)}"),);
          if (allScores[user].length > i) {
            print(allScores[user][i]);
          } else {
            print(0);
          }

        });
      }
    });
  }

  @override
  void initState() {
    connection.on("ScoreBoard", (scores) => _doThis(scores[0]));
    connection.invoke("GetScores", args: ["GroupOfJoshua", 0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8f92c9),
      appBar: AppBar(
        title: Text("Thoughts & Crosses Scores"),
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: roundScoreList,
          ),
        ),
      ]),
    );
  }
}
