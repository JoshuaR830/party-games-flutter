import 'package:flutter/material.dart';
import 'package:party_games/Pages/GamesLibraryPage.dart';
import 'package:signalr_core/signalr_core.dart';
import 'Pages/ConnectionError.dart';
import 'Pages/ThoughtsAndCrossesPage.dart';

int countDown = 0;

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

class PartyGames extends StatelessWidget {

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