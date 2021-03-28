
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_love/style/common-style.dart';
import 'package:real_love/style/component/element/elementBacground.dart';

class BackgroundPr extends StatelessWidget{
  final double height;
  const BackgroundPr({ this.height = 175});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipPath(
      clipper: CustomShape(),
      child: Container(
        height: height,
        color: CommonStyle.colorPink,
      ),
    );
  }
  
}