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
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: userNameController,
            validator: (value) {
              if(value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          RaisedButton(
            color: Colors.deepPurple,
            onPressed: () {
              if(_formKey.currentState.validate()) {
                Navigator.pop(context, userNameController.text);
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}