import 'package:flutter/material.dart';
import 'Pages/ThoughtsAndCrossesPage.dart';

int countDown = 0;

Future<void> main() async {
  runApp(PartyGames());
}

class PartyGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThoughtsAndCrossesGrid();
  }
}