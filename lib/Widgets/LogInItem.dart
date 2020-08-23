import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogInItem extends StatefulWidget
{
  final Color textColor;
  final Color backgroundColor;
  final String text;

  LogInItem(
  {
    @required this.text,
    @required this.textColor,
    @required this.backgroundColor,
  });

  @override
  _LogInItemState createState() => _LogInItemState();
}

class _LogInItemState extends State<LogInItem>{
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: widget.backgroundColor,
          ),
          child: Container(
            width: 200,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                    widget.text,
                    style: TextStyle(color: widget.textColor)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}