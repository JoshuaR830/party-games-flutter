import 'package:flutter/material.dart';
import 'package:signalr_client/signalr_client.dart';
import 'package:logging/logging.dart';

import '../LoginForm.dart';

class ThoughtsAndCrossesPage extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {


    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });

    final logger = Logger('ThoughtsAndCrossesPage');

    //final serverUrl = 'games-by-joshua.herokuapp.com/chatHub';
    final serverUrl = 'http://192.168.1.76:5001/chatHub';
    final hubConnection = HubConnectionBuilder().withUrl(serverUrl).configureLogging(logger).build();
    hubConnection.onclose((error) => print("Connection closed"));

    final Dialog loginDialog = Dialog(
      backgroundColor: Color(0xFF8f92c9),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoginForm(),
          ],
        ),
      ),
    );

    return Center(
      child: RaisedButton(
        onPressed: () async {
          final name = await showDialog(context: context, builder: (BuildContext context) => loginDialog);
          await hubConnection.start();
          final result = await hubConnection.invoke("Startup", args: <Object>["GroupOfJoshua", name, 0]);
          final result2 = await hubConnection.invoke("SetupNewUser", args: <Object>["GroupOfJoshua", name]);
          logger.fine(result2);
        },
        child: Text('Smash this'),
      ),
    );


  }

}