import 'package:flutter/material.dart';
import 'package:party_games/Pages/GamesLibraryPage.dart';
import 'package:signalr_core/signalr_core.dart';
import 'Pages/ThoughtsAndCrossesPage.dart';

int countDown = 0;

Future<void> main() async {
  connection.onclose((error) => print("Connection closed"));
  await connection.start();
  runApp(PartyGames());
}


final serverUrl = 'https://games-by-joshua.herokuapp.com/chatHub';
//final serverUrl = 'http://192.168.1.76:5001/chatHub';
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