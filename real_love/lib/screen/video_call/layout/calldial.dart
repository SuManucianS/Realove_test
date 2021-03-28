import 'package:flutter/material.dart';
import 'package:real_love/screen/video_call/widget/body_forDial.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/utils/sizeConfig.dart';

class DialScreen extends StatelessWidget {
  final String id;

  const DialScreen({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBackgoundColor,
      body: BodyForDial(id: id,),
    );
  }
}
