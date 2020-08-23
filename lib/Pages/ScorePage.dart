import 'package:flutter/material.dart';

import '../main.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

  var roundScoreList = <Widget>[];
  var totalScoreList = <Widget>[];

  Map<String, dynamic> allScores;

  List<Widget> _buildList() {
    print("Broken down");
    roundScoreList.clear();
    if(allScores == null) {
      return <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 64),
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF8f92c9),
            ),
          ),
        ),
      ];
    }
    var users = allScores.keys.toList();
    var something = allScores[users[0]].length;
    var totalUserScores = Map<String, int>();


    for(var i = 0; i < something; i++) {
      print("Round ${i + 1}");


      roundScoreList.add(
        ListTile(
          title: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.white30
              ),
              child: Container(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      "Round ${i + 1}",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          decoration: TextDecoration.underline
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
        totalUserScores.putIfAbsent(user, () => 0);
        print(">>>${allScores[user]}");
        print(user[0].toUpperCase() + user.substring(1));

        totalUserScores[user] = totalUserScores[user] + (allScores[user].length > i ? allScores[user][i] : 0);
        print(totalUserScores);
        roundScoreList.add(
          ListTile(
            title: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.deepPurple,
                ),
                child: Container(
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


    List<Widget> _buildTotal() {
      print("Total");
      totalScoreList.clear();
      if(allScores == null) {
        return <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 64),
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFF8f92c9),
              ),
            ),
          ),
        ];
      }

      var users = allScores.keys.toList();
      var totalUserScores = Map<String, int>();

      users.forEach((user) {
        for(var i = 0; i < allScores[user].length; i++) {
          totalUserScores.putIfAbsent(user, () => 0);

          totalUserScores[user] = totalUserScores[user] +
              (allScores[user].length > i ? allScores[user][i] : 0);
        }
      });

    users.forEach((user) {
      totalScoreList.insert(0, ListTile(
        title: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.deepPurple,
            ),
            child: Container(
              width: 200,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    "${user[0].toUpperCase()}${user.substring(1)}: ${totalUserScores[user]??0}",
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
    });

    return totalScoreList;
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
    connection.invoke("GetScores", args: [groupName, 0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Updating scores");
    print(this.roundScoreList);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFF8f92c9),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
                Tab(text: 'Total scores'),
                Tab(text: 'Round scores'),
            ],
          ),
          title: Text("Thoughts & Crosses Scores"),
        ),
        body: TabBarView(
          children: [
            Container(child:
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: _buildTotal(),
                ),
              ),
            ]),
            ),
            Container(
              child:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: _buildList(),
                  ),
                ),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
