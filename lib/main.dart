import 'package:flutter/material.dart';
import 'package:party_games/Pages/GamesLibraryPage.dart';
import 'Pages/ThoughtsAndCrossesPage.dart';

int countDown = 0;

Future<void> main() async {
  runApp(PartyGames());
}

class PartyGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GamesLibraryPage();
  }
}