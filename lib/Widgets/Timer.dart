import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget{

  final int timerLength;

  TimerWidget({
      @required this.timerLength
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {

  int countDown = 0;
  var timer;

  @override
  void initState() {
    function();
    super.initState();
  }

  void function() {
    countDown = widget.timerLength;
    timer = new Timer.periodic(Duration(seconds: 1), (Timer t) => {
      setState(() {
        countDown --;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    var minutes = countDown ~/ 60;
    var seconds = countDown - (60 * minutes);
    var timerText = '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';

    if(countDown <= 0) {
      timer.cancel();
    }

    return Text(
      timerText.toString(),
      style: TextStyle(
        color: countDown > 10? Color(0xFF55EDBB) : Color(0xFFFF0000),
        fontSize: 24,
      ),
    );
  }
}