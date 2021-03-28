import 'package:flutter/material.dart';

abstract class StyleWidget {
  static const InputDecoration kInputDecoration = InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide(color: Colors.lightGreen, width: 5.0)),
    labelText: 'Label Text',
  );
  static const TextStyle kInputTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.blue,
  );
}