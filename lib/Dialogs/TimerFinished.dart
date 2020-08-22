import 'package:flutter/material.dart';

import '../main.dart';

int counter = 1;

final gameOverDialog = Dialog(
  backgroundColor: Colors.transparent,
  insetPadding: EdgeInsets.all(16),
  child: GameOverContent(),
);

class GameOverContent extends StatefulWidget {

  @override
  _GameOverContentState createState() => _GameOverContentState();
}

class _GameOverContentState extends State<GameOverContent> {
  int initialRoundNumber;
  int roundNumber;
  int originalInput = counter;

  void setupDismissNavigation() {
    connection.on("ReceiveCompleteRound", (result) => dismissNavigation());
  }

  void dismissNavigation() {
    if(!mounted) return;
    setState(() {
      this.initialRoundNumber = this.roundNumber;
      roundNumber ++;
      counter++;
    });

    if(this.initialRoundNumber != this.roundNumber) {
      Navigator.pop(context);
      this.initialRoundNumber = this.roundNumber;
    }
  }

  void initState() {
    setupDismissNavigation();
    this.roundNumber = 1;
    this.initialRoundNumber = 0;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red[900], Colors.brown[700]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 120,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Round $originalInput complete', style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),),
          ),

          RaisedButton(
            child: Text('End'),
            onPressed: () async {
              await connection.invoke("CompleteRound", args: [groupName]);
            },
          ),
        ],
      ),
    );
  }
}
