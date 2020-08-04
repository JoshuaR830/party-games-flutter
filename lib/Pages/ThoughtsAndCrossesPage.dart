import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

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

