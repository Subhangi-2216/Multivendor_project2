import 'package:flutter/material.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 241, 188, 142),
      content: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      )));
}
