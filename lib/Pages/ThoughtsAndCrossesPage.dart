import 'package:flutter/material.dart';
import 'package:party_games/Widgets/CornerInformation.dart';
import 'package:party_games/Widgets/LogInItem.dart';
import 'package:party_games/Widgets/ThoughtsAndCrossesGridSquare.dart';
import 'package:party_games/Widgets/Timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../presentation/custom_icons_icons.dart';

import '../Dialogs/Dialog.dart';
import 'ScorePage.dart';

class ThoughtsAndCrossesPage extends StatefulWidget {
  ThoughtsAndCrossesPage({Key key}) : super(key: key);

  _ThoughtsAndCrossesPageState createState() => _ThoughtsAndCrossesPageState();
}

class _ThoughtsAndCrossesPageState extends State<ThoughtsAndCrossesPage> {
  final _loggedInUserList = <Widget>[];
  bool isLoggedIn;
  bool something;

  void startOnTimerStart(time) {
    something = true;

    var timerLength = time[0] * 60 + time[1];

    print("Navigate on time");
    print(context);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ThoughtsAndCrossesGrid(timerLength: timerLength,)),
    );
  }

  Future _connectToHub() async {
    connection.on('LoggedInUsers', (message) => renderStuff(message[0]));
    connection.on('ReceiveTimeStart', (message) => startOnTimerStart(message[0]));
  }

  renderStuff(List users) {

    if(name == "") return;

    _loggedInUserList.clear();

    if (!mounted) {
      return;
    }
    setState(() {
      isLoggedIn = true;

      _loggedInUserList.add(LogInItem(
        backgroundColor: Colors.white30,
        textColor: Colors.deepPurple,
        text: groupName,
      ));

      users.forEach((user) => _loggedInUserList.add(LogInItem(
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        text: user,
      )));
    });
  }

  @override
  void initState() {
    isLoggedIn = false;
    something = true;
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
    return MaterialApp(
      title: 'Thoughts & Crosses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF8f92c9),
        floatingActionButton: Visibility(
          child: FloatingActionButton(
            child: Icon(Icons.play_arrow),
            onPressed: () {
              connection.invoke("JoinRoom", args: [groupName, name, 0]);
              connection.invoke("StartServerGame", args: [groupName, [2, 30]]);
            },
          ),
          visible: isLoggedIn,
        ),
        appBar: AppBar(
          title: Text('Thoughts & Crosses'),
          actions: <Widget>[
            Visibility(
              child: IconButton(
                icon: Icon(CustomIcons.Trophy),
                onPressed: () {
                  print("Hello");
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScorePage(),
                      )
                  );
                },
            ),
            visible: isLoggedIn,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          Visibility( child: RaisedButton(
                onPressed: () async {
                  final loginData = await showDialog(
                      context: context,
                      builder: (BuildContext context) => loginDialog);

                  name = loginData.name;
                  groupName = loginData.groupName;

                  final preferences = await SharedPreferences.getInstance();
                  await preferences.setString('userName', name);
                  await preferences.setString('groupName', groupName);

                  if(name == "Cancelled" || name == null || groupName == "Cancelled" || groupName == null) {
                    return;
                  }

                  await connection.invoke("AddToGroup", args: [groupName]);
                  await connection.invoke("Startup", args: [groupName, name, 0]);
                  await connection.invoke("SetupNewUser", args: [groupName, name]);
                  await connection.invoke("AddToGroup", args: [groupName]);
                  await connection.invoke('ResetGame', args: [groupName, name, 0]);
                },
                color: Colors.deepPurple,

                child:Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
                visible: !isLoggedIn,
              ),
              Expanded(
                child: _buildListItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThoughtsAndCrossesGrid extends StatefulWidget {

  final int timerLength;

  ThoughtsAndCrossesGrid(
  {
    @required this.timerLength
  });

  _ThoughtsAndCrossesGridState createState() => _ThoughtsAndCrossesGridState();
}

class _ThoughtsAndCrossesGridState extends State<ThoughtsAndCrossesGrid> {
  final _topics = <String>[];
  final _statuses = <bool>[];
  final _guesses = <String>[];
  var score = 0;
  var letter = " ";
  var isContinueButtonVisible = false;

  void _setUpGrid(List gridInfo) {
    if (!mounted) {
      return;
    }

    print("Setup word grid");

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
      print(this._statuses);
      print(this._guesses);
    });
  }

  void _setScore(int newScore) {
    if (!mounted) {
      return;
    }

    setState(() {
      this.score = newScore;
    });
  }

  void _updateLetter(String newLetter) {
    if (!mounted) {
      return;
    }
    setState(() {
      this.letter = newLetter;
    });
  }

  void _allowCompletion(){
    if (!mounted) {
      return;
    }
    setState(() {
      isContinueButtonVisible = true;
    });
  }

  void resetGame() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void _submitScores() {
    if(!mounted) return;
    print("<><><><>");
    connection.invoke("UpdateScoreBoard", args: [groupName, name]);
    _setScore(0);
    isContinueButtonVisible = false;
    Navigator.of(context).pop();
  }

  Future _setUpConnections() async {
    Object topics;

    connection.on('LoggedInUsers', (message) => print(message.toString()));
    connection.on('ReceiveLetter', (message) => _updateLetter(message[0]));
    connection.on('ReceiveWordGrid', (message) => _setUpGrid(message[0]));
    connection.on('ScoreCalculated', (message) => _setScore(message[0]));
    connection.on("ReceiveCompleteRound", (result) => _allowCompletion());
    connection.on("CompletedScores", (result) => _submitScores());

    await connection.invoke("AddToGroup", args: [groupName]);
    await connection.invoke("Startup", args: [groupName, name, 0]);
    await connection.invoke("SetupNewUser", args: [groupName, name]);
    await connection.invoke("AddToGroup", args: [groupName]);
    await connection.invoke('ResetGame', args: [groupName, name, 0]);
  }

  @override
  void initState() {
    _setUpConnections().then((value) {
      print('>>>Async done');
    });
    super.initState();
  }

  Widget _buildGrid(double gridItemSize) {
    final _gridItems = <Widget>[];

    if (_topics.length == 9) {
      for (var i = 0; i < 9; i++) {
        _gridItems.add(
          ThoughtsAndCrossesGridSquare(
            topic: _topics[i],
            isGuessed: _statuses[i],
            userGuess: _guesses[i],
            gridItemSize: gridItemSize,
          ),
        );
      }
    }

    return Padding(
      padding: EdgeInsets.only(
          top: 64,
          bottom: 64,
      ),
      child: GridView.count(
        crossAxisCount: 3,
        physics: ClampingScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        primary: true,

        children: _gridItems,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeContext = MediaQuery.of(context);

    var width = MediaQuery.of(context).size.width - 32;
    var height = sizeContext.size.height - kToolbarHeight - 108 - sizeContext.padding.top - sizeContext.padding.bottom;
    final gridSize = height > width ? width : height;

    return MaterialApp(
      title: 'Thoughts & Crosses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          backgroundColor: Color(0xFF8f92c9),
          floatingActionButton: Visibility(
            child: FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                print("<Hello>");
                connection.invoke("CollectScores", args: [groupName]);

                // Somehow need to pop the context for everyone - not just the person who presses it
//                Navigator.pop(context);
              },
          ),
          visible: isContinueButtonVisible,
          ),
          appBar: AppBar(
            title: Text('Thoughts & Crosses'),
          ),
          body: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: gridSize,
                  height: gridSize + 128,
                  child: _buildGrid((gridSize - 16)/3),
                ),
              ),
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
                  timerLength: widget.timerLength,
                ),
              ),
              CornerInformation(
                icon: CustomIcons.Trophy,
                isTop: false,
                isLeft: true,
                text: score.toString(),
              ),
            ],
          )),
    );
  }
}
