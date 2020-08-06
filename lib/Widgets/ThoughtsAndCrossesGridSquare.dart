import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_games/Pages/ThoughtsAndCrossesPage.dart';

class ThoughtsAndCrossesGridSquare extends StatefulWidget {
  final String topic;
  final bool isGuessed;
  final String userGuess;

  ThoughtsAndCrossesGridSquare({
    @required this.topic,
    @required this.isGuessed,
    @required this.userGuess,
  });

  @override
  _ThoughtsAndCrossesGridSquareState createState() =>
      _ThoughtsAndCrossesGridSquareState();
}

class _ThoughtsAndCrossesGridSquareState
    extends State<ThoughtsAndCrossesGridSquare> {
  var thing = false;

  @override
  Widget build(BuildContext context) {
    thing = widget.isGuessed;

    return Container(
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



    return RaisedButton(
      onPressed: () {
        setState(() {
          if (thing) {
            thing = false;
            connection.invoke('SetIsValidForCategory', args: ['GroupOfJoshua', 'Joshua', widget.topic, thing]);
            connection.invoke('CalculateScore', args: ['GroupOfJoshua', 'Joshua']);
            connection.invoke('JoinRoom', args: ['GroupOfJoshua', 'Joshua', 0]);
          } else {
            thing = true;
            connection.invoke('SetIsValidForCategory', args: ['GroupOfJoshua', 'Joshua', widget.topic, thing]);
            connection.invoke('CalculateScore', args: ['GroupOfJoshua', 'Joshua']);
            connection.invoke('JoinRoom', args: ['GroupOfJoshua', 'Joshua', 0]);
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
    controller = TextEditingController(text: widget.userGuess);
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

