import 'package:flutter/material.dart';

import '../main.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

  var roundScoreList = <Widget>[];

  Map<String, dynamic> allScores;

  List<Widget> _buildList() {

    if(allScores == null) {
      return <Widget>[
        ListTile(
          title: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.deepPurple,
              ),
              child: SizedBox(
                height: 48,
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ];
    }
    var users = allScores.keys;
    var something = allScores["joshua"].length;

    for(var i = 0; i < something; i++) {
      print("Round ${i + 1}");


      roundScoreList.add(
        ListTile(
          title: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.deepPurple,
              ),
              child: SizedBox(
                height: 48,
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      "Round ${i + 1}",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      users.forEach((user) {
        print(">>>${allScores[user]}");
        print(user[0].toUpperCase() + user.substring(1));

        roundScoreList.add(
          ListTile(
            title: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.deepPurple,
                ),
                child: SizedBox(
                  height: 48,
                  width: 200,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "${user[0].toUpperCase() + user.substring(
                            1)}: ${(allScores[user].length > i
                            ? allScores[user][i]
                            : 0)}",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );


        if (allScores[user].length > i) {
          print(allScores[user][i]);
        } else {
          print(0);
        }
      });
    }
    return roundScoreList;
  }

  void _doThis(scores) {
    if(!mounted) return;
    setState(() {
      allScores = scores;

      roundScoreList.clear();

    });
    print(roundScoreList);
  }



  @override
  void initState() {
    connection.on("ScoreBoard", (scores) => _doThis(scores[0]));
    connection.invoke("GetScores", args: ["GroupOfJoshua", 0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Updating scores");
    print(this.roundScoreList);
    return Scaffold(
      backgroundColor: Color(0xFF8f92c9),
      appBar: AppBar(
        title: Text("Thoughts & Crosses Scores"),
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: _buildList(),
          ),
        ),
      ]),
    );
  }
}
