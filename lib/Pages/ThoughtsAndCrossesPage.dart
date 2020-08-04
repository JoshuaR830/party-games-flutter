import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

import 'Dialog.dart';


//final serverUrl = 'games-by-joshua.herokuapp.com/chatHub';
final serverUrl = 'http://192.168.1.76:5001/chatHub';
final connection = HubConnectionBuilder().withUrl(serverUrl,
    HttpConnectionOptions(
      logging: (level, message) => print(message),
    )).build();

Future _connectToHub() async {
  connection.onclose((error) => print("Connection closed"));
  await connection.start();
  print('We got here');
  connection.on('LoggedInUsers', (message) => print(message.toString()));
  connection.on('ReceiveLetter', (message) => print(message.toString()));
}

class ThoughtsAndCrossesPage extends StatefulWidget {
  ThoughtsAndCrossesPage({Key key}) : super(key: key);

  _ThoughtsAndCrossesPageState createState() => _ThoughtsAndCrossesPageState();
}

class _ThoughtsAndCrossesPageState extends State<ThoughtsAndCrossesPage> {

  @override
  void initState() {
    _connectToHub().then((value) {
      print('Async done');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return Center(
      child: RaisedButton(
        onPressed: () async {
          final name = await showDialog(context: context, builder: (BuildContext context) => loginDialog);

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
    );
  }
}