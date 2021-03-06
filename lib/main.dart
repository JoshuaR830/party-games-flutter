import 'package:flutter/material.dart';
import 'package:party_games/Pages/GamesLibraryPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';
import 'Pages/ConnectionError.dart';
import 'Pages/ThoughtsAndCrossesPage.dart';

int countDown = 0;
String name = '';
String groupName = 'default';

Future<void> main() async {
  setupConnection();
}

Future<void> setupConnection() async {
  connection.onclose((error) => print("Connection closed"));
  try {
    await connection.start();
    runApp(PartyGames());
  } catch (e){
    print("There was a problem connecting to the server");
    runApp(ConnectionError());
  }
}

final serverUrl = 'https://games-by-joshua.herokuapp.com/chatHub';
//final serverUrl = 'http://192.168.1.86:5001/chatHub';
//final serverUrl = 'http://192.168.1.72:5001/chatHub';
final connection = HubConnectionBuilder()
    .withUrl(
    serverUrl,
    HttpConnectionOptions(
      logging: (level, message) => print(message),
    ))
    .build();

class PartyGames extends StatefulWidget {
  @override
  _PartyGamesState createState() => _PartyGamesState();
}

class _PartyGamesState extends State<PartyGames> {

  _setupExistingData() async {
    final preferences = await SharedPreferences.getInstance();
    name = preferences.getString('userName');
    groupName = preferences.getString('groupName') ?? 'default';
    print(groupName);
  }

  @override
  void initState() {
    _setupExistingData().then((value) {
      print("Async done");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GamesLibraryPage();
  }
}

class ConnectionError extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ConnectionErrorPage();
  }
}