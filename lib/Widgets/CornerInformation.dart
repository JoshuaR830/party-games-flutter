import 'package:flutter/material.dart';
import 'package:party_games/Widgets/Timer.dart';

class CornerInformation extends StatefulWidget {
  final IconData icon;
  final String text;
  final TimerWidget timerWidget;
  final bool isTop;
  final bool isLeft;

  CornerInformation(
    {@required this.icon,
      @required this.isTop,
      @required this.isLeft,
      this.text,
      this.timerWidget
    }
  );

  @override
  _CornerInformationState createState() => _CornerInformationState();
}

class _CornerInformationState extends State<CornerInformation> {
  @override
  Widget build(BuildContext context)
  {
    Widget myText;

    if(widget.text != null) {
      myText = Text(
        widget.text,
        style: TextStyle(
          color: Color(0xFF55edbb),
          fontSize: 24,
        ),
      );
    }

    if(widget.timerWidget != null) {
      myText = widget.timerWidget;
    }

    createButtonContent(BorderRadius radius) {
      return Container(
        child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    widget.icon,
                    color: Color(0xFF55edbb),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: myText,
                ),
              ]
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF8f92c9),
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
                color: Color(0xFF55edbb),
                spreadRadius: 4,
                blurRadius: 4.0
            ),
          ],
        ),
      );
    }

    BorderRadius _radius;
    Positioned _position;

    final boxWidth =  MediaQuery.of(context).size.width/3;

    if (widget.isLeft && widget.isTop) {
      _radius = BorderRadius.only(
        bottomRight: Radius.circular(20),
      );

      _position = Positioned(
          top: 0,
          left: 0,
          width: boxWidth,
          height: 54,
          child: createButtonContent(_radius)
      );
    }

    if (!widget.isLeft && widget.isTop) {
      _radius = BorderRadius.only(
        bottomLeft: Radius.circular(20),
      );

      _position = Positioned(
          top: 0,
          right: 0,
          width: boxWidth,
          height: 54,
          child: createButtonContent(_radius)
      );
    }

    if (widget.isLeft && !widget.isTop) {
      _radius = BorderRadius.only(
        topRight: Radius.circular(20),
      );

      _position = Positioned(
          bottom: 0,
          left: 0,
          width: boxWidth,
          height: 54,
          child: createButtonContent(_radius)
      );
    }

    if (!widget.isLeft && !widget.isTop) {
      _radius = BorderRadius.only(
        topLeft: Radius.circular(20),
      );

      _position = Positioned(
          bottom: 0,
          right: 0,
          width: boxWidth,
          height: 54,
          child: createButtonContent(_radius)
      );
    }

    return _position;
  }
}