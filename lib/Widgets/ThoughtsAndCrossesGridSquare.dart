import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_games/Pages/ThoughtsAndCrossesPage.dart';

Map<String, dynamic> guesses;

class ThoughtsAndCrossesGridSquare extends StatefulWidget {
  final String topic;
  final bool isGuessed;
  final String userGuess;
  final bool isInputMode;

  ThoughtsAndCrossesGridSquare({
    @required this.topic,
    @required this.isGuessed,
    @required this.userGuess,
    @required this.isInputMode,
  });

  @override
  _ThoughtsAndCrossesGridSquareState createState() =>
      _ThoughtsAndCrossesGridSquareState();
}

class _ThoughtsAndCrossesGridSquareState
    extends State<ThoughtsAndCrossesGridSquare> {
  var thing = false;
  var displayInputs = true;

  void doSomething() {
//    print(something);
//
//    Map<String, dynamic> somethingElse = jsonDecode(something);
//    guesses = somethingElse;
//
//    print(somethingElse[widget.topic]);
//    print(guesses[widget.topic]);
    setState(() {
      displayInputs = false;
    });
  }

  void doSomethingElse() {
    setState(() {
      displayInputs = true;
    });
  }

  _getReadyForTimerDismiss() {
    connection.on("ReceiveCompleteRound", (value) => doSomething());
    connection.on("StartNewRound", (value) => doSomethingElse());
//    connection.on("StartNewRound", (value) => doSomethingElse());
  }

  @override
  void initState() {
    _getReadyForTimerDismiss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    thing = widget.isGuessed;


    Widget gridSquare;

    if(displayInputs) {
      print("Hello there");
      gridSquare = Container(
        padding: EdgeInsets.all(4),
        color: thing ? Colors.greenAccent[200] : Colors.purple[200],
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 8,
              child: SizedBox(
                child: Text(
                  widget.topic,
                  textAlign: TextAlign.center,
                ),
                width: 80,
              ),
            ),
            Positioned(
              bottom: 8,
              width: 80,
              child: SizedBox(
                child: GridForm(
                  topic: widget.topic,
                  userGuess: widget.userGuess,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      print("Not a thing");
      gridSquare = RaisedButton(
        onPressed: () {
          setState(() {
            if (thing) {
              thing = false;
              connection.invoke('SetIsValidForCategory', args: ['GroupOfJoshua', 'Joshua', widget.topic, thing]);
              connection.invoke('CalculateScore', args: ['GroupOfJoshua', 'Joshua']);
            } else {
              thing = true;
              connection.invoke('SetIsValidForCategory', args: ['GroupOfJoshua', 'Joshua', widget.topic, thing]);
              connection.invoke('CalculateScore', args: ['GroupOfJoshua', 'Joshua']);
            }
          });
        },
        padding: EdgeInsets.all(4),
        color: thing ? Colors.greenAccent[200] : Colors.purple[200],
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 8,
              child: SizedBox(
                child: Text(
                  widget.topic,
                  textAlign: TextAlign.center,
                ),
                width: 80,
              ),
            ),
            Positioned(
              bottom: 8,
              child: SizedBox(
                child: Text(widget.userGuess, textAlign: TextAlign.center),
                width: 80,
              ),
            ),
          ],
        ),
      );
    }

    return gridSquare;
  }
}

class GridForm extends StatefulWidget {

  final String topic;
  final String userGuess;

  GridForm({
    @required this.topic,
    @required this.userGuess,
  });

  @override
  _GridFormState createState() => _GridFormState();
}

class _GridFormState extends State<GridForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller;

  @override
  void initState() {
    print("Hello");
    controller = TextEditingController(text: (widget.userGuess.length > 0? widget.userGuess:""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget> [
          TextFormField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, height: 1, fontSize: 14, ),
          onChanged: (text) {
            print(text);
            connection.invoke("SetGuessForCategory", args: ["GroupOfJoshua", "Joshua", widget.topic, text]);
          },

          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(8),
            fillColor: Colors.white,
            filled: true,
          ),
          )
        ],
      ),
    );
  }
}

