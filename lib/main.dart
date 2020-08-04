import 'package:flutter/material.dart';

import 'package:signalr_core/signalr_core.dart';
import 'package:logging/logging.dart';

import 'Pages/GamesLibraryPage.dart';
import 'Pages/ThoughtsAndCrossesPage.dart';

Future<void> main() async {

//  Logger.root.level = Level.ALL;
//
//  Logger.root.onRecord.listen((record) {
//    print('${record.level.name}: ${record.time}: ${record.message}');
//  });

//  final logger = Logger('ThoughtsAndCrossesPage');

  //final serverUrl = 'games-by-joshua.herokuapp.com/chatHub';
//  final serverUrl = 'http://192.168.1.76:5001/chatHub';
//  final connection = HubConnectionBuilder().withUrl(serverUrl,
//      HttpConnectionOptions(
//        logging: (level, message) => print(message),
//      )).build();
//
//  await connection.start();
//  connection.on('LoggedInUsers', (message) => logger.info(message.toString()));
//  connection.on('ReceiveLetter', (message) => logger.info(message.toString()));
//
//  await connection.invoke("AddToGroup", args: ['GroupOfJoshua']);
//  await connection.invoke('JoinRoom', args: ['GroupOfJoshua', 'Joshua', 0]);
//  await connection.invoke('StartServerGame', args: ['GroupOfJoshua', [2, 30]]);

  runApp(PartyGames());
}

class PartyGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games Library',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF8f92c9),
        appBar: AppBar(
          title: Text('Games Library'),
        ),
//        body: GamesLibraryPage() // This creates the body of the page
        body: ThoughtsAndCrossesPage() // This creates the body of the page
      ),
    );
  }
}