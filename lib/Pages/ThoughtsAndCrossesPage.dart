import 'package:flutter/material.dart';
import 'package:party_games/Widgets/CornerInformation.dart';
import 'package:party_games/Widgets/ThoughtsAndCrossesGridSquare.dart';
import 'package:party_games/Widgets/Timer.dart';
import 'package:signalr_core/signalr_core.dart';
import '../presentation/custom_icons_icons.dart';

import 'Dialog.dart';

//final serverUrl = 'https://games-by-joshua.herokuapp.com/chatHub';
final serverUrl = 'http://192.168.1.76:5001/chatHub';
final connection = HubConnectionBuilder()
    .withUrl(
        serverUrl,
        HttpConnectionOptions(
          logging: (level, message) => print(message),
        ))
    .build();



class ThoughtsAndCrossesPage extends StatefulWidget {
  ThoughtsAndCrossesPage({Key key}) : super(key: key);

  _ThoughtsAndCrossesPageState createState() => _ThoughtsAndCrossesPageState();
}

class _ThoughtsAndCrossesPageState extends State<ThoughtsAndCrossesPage> {
  final _loggedInUserList = <Widget>[];
  Future _connectToHub() async {
    connection.onclose((error) => print("Connection closed"));
    await connection.start();
    connection.on('LoggedInUsers', (message) => renderStuff(message[0]));
    connection.on('ReceiveLetter', (message) => print(message.toString()));
  }

  renderStuff(List users) {
    _loggedInUserList.clear();

    setState(() {
      users.forEach((user) => _loggedInUserList.add(ListTile(
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
                  child: Text(user,
                  style: TextStyle(
                    color: Colors.white
                  )),
                ),
              ),
            ),
          ),
        ),
      )));
    });
  }

  @override
  void initState() {
    _connectToHub().then((value) {
      print('Async done');
    });
    super.initState();
  }

  Widget _buildListItems() {
    final _users = <Widget>[];
    _loggedInUserList.forEach((user) => _users.add(user));

    return ListView(
      shrinkWrap: true,
      children: _users,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              final name = await showDialog(
                  context: context,
                  builder: (BuildContext context) => loginDialog);

              await connection.invoke("AddToGroup", args: ['GroupOfJoshua']);
              await connection.invoke("Startup", args: ['GroupOfJoshua', name, 0]);
              await connection.invoke("SetupNewUser", args: ['GroupOfJoshua', name]);
              await connection.invoke("AddToGroup", args: ['GroupOfJoshua']);
              await connection.invoke('JoinRoom', args: ['GroupOfJoshua', name, 0]);
            },
            color: Colors.deepPurple,
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: _buildListItems(),
          ),
        ],
      ),
    );
  }
}

class ThoughtsAndCrossesGrid extends StatefulWidget {
  ThoughtsAndCrossesGrid({Key key}) : super(key: key);

  _ThoughtsAndCrossesGridState createState() => _ThoughtsAndCrossesGridState();
}

class _ThoughtsAndCrossesGridState extends State<ThoughtsAndCrossesGrid> {

  final _topics = <String>[];
  final _statuses = <bool>[];
  final _guesses = <String>[];
  var score = 0;
  var letter = " ";

  void _setUpGrid(List gridInfo) {
    setState(() {
      this._topics.clear();
      this._statuses.clear();
      this._guesses.clear();
      gridInfo.forEach((item) {
        this._topics.add(item["item1"]);
        this._statuses.add(item["item3"]);
        this._guesses.add(item["item2"]);
      });
      print(this._topics);
    });
  }

  void _setScore(int newScore) {
    setState(() {
      this.score = newScore;
    });
  }

  void _updateLetter(String newLetter) {
    setState(() {
      this.letter = newLetter;
    });
  }

  Future _setUpConnections() async {
    final name = 'Joshua';

    Object topics;

    connection.onclose((error) => print("Connection closed"));
    await connection.start();
    connection.on('LoggedInUsers', (message) => print(message.toString()));
    connection.on('ReceiveLetter', (message) => _updateLetter(message[0]));
    connection.on('ReceiveWordGrid', (message) => _setUpGrid(message[0]));
    connection.on('ScoreCalculated', (message) => _setScore(message[0]));

    print(">>> $topics");

    await connection.invoke("AddToGroup", args: ['GroupOfJoshua']);
    await connection.invoke("Startup", args: ['GroupOfJoshua', name, 0]);
    await connection.invoke("SetupNewUser", args: ['GroupOfJoshua', name]);
    await connection.invoke("AddToGroup", args: ['GroupOfJoshua']);
    await connection.invoke('JoinRoom', args: ['GroupOfJoshua', name, 0]);
  }

  @override
  void initState() {
    _setUpConnections().then((value) {
      print('Async done');
    });
    super.initState();
  }

  Widget _buildGrid() {
//    final _topics = <String>['Topic 1', 'Topic 2', 'Topic 3', 'Topic 4', 'Topic 5', 'Topic 6', 'Topic 7', 'Topic 8', 'Topic 9'];
    final _gridItems = <Widget>[];

    if(_topics.length == 9) {
      for (var i = 0; i < 9; i++) {
        _gridItems.add(
          ThoughtsAndCrossesGridSquare(
            topic: _topics[i],
            isGuessed: _statuses[i],
            userGuess: _guesses[i],
          ),
        );
      }
    }

    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: _gridItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thoughts & Crosses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF8f92c9),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
        ),
        appBar: AppBar(
          title: Text('Thoughts & Crosses'),
        ),
        body: Stack(
          children: <Widget>[
            CornerInformation(
              icon: Icons.edit,
              isTop: true,
              isLeft: true,
              text: this.letter,
            ),
            CornerInformation(
              icon: Icons.alarm,
              isTop: true,
              isLeft: false,
              timerWidget: TimerWidget(
                timerLength: 150,
              ),
            ),
            CornerInformation(
              icon: CustomIcons.Trophy,
              isTop: false,
              isLeft: true,
              text: score.toString(),
            ),
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: _buildGrid(),
              ),
            ),
          ],
        )
      ),
    );
  }
}
