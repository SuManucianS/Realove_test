import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_love/style/common-style.dart';

class ButtonWidget extends StatelessWidget{
  ButtonWidget({Key key, this.onTap, this.text, this.context}) : super(key: key);
  final Function onTap;
  final String text;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            gradient: new LinearGradient(
                colors: [
                  CommonStyle.colorPink,
                  Colors.white
                ]
            ),
        ),
        padding: const EdgeInsets.all(0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
            color: CommonStyle.colorWhite
          ),
        ),
      ),
    );
  }
  
}