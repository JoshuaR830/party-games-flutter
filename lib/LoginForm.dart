import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
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
                controller: userNameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              RaisedButton(
                color: Colors.deepPurple,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.pop(context, userNameController.text);
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
            top: -10,
            right: -10,
            child: Ink(
              decoration: ShapeDecoration(
                color: Colors.deepPurple,
                shape: CircleBorder(),
              ),
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context, 'Cancelled');
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