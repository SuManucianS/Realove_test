import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_love/style/component/stylewidget.dart';

class InputTextField extends StatelessWidget{
  final String label;
  final TextEditingController controller;
  final bool isVis;
  final int maxline;
  final int minline;
  InputTextField({this.label, this.controller, this.isVis, this.maxline, this.minline});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: TextField(
        keyboardType: TextInputType.multiline,
        controller: controller,
        decoration: StyleWidget.kInputDecoration.copyWith(labelText: label),
        style: StyleWidget.kInputTextStyle,
        obscureText: isVis,
        maxLines: maxline,
        minLines: minline,
      ),
    );
  }

}
