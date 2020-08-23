import 'package:flutter/material.dart';

import 'LoginData.dart';
import 'main.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final groupNameController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Login now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    labelText: 'User name'
                ),
                controller: userNameController..text = name,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Group name',

                  labelStyle: TextStyle(

                  )
                ),
                controller: groupNameController..text = groupName,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a group name';
                  }
                  return null;
                },
              ),
              RaisedButton(
                color: Colors.deepPurple,
                onPressed: () {
                  name = userNameController.text;
                  if (_formKey.currentState.validate()) {
                    var loginData = new LoginData(userNameController.text, groupNameController.text);
                    Navigator.pop(context, loginData);
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Positioned(
            top: -12,
            right: -12,
            width: 30,
            height: 30,
            child: Ink(
              decoration: ShapeDecoration(
                color: Colors.deepPurple,
                shape: CircleBorder(),
              ),
              child: IconButton(
                iconSize: 12,
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context, new LoginData('Cancelled', 'Cancelled'));
                },
                icon: Icon(Icons.close),
                tooltip: "Close modal",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
