import 'package:flutter/material.dart';

import '../LoginForm.dart';

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