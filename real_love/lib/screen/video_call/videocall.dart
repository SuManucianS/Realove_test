import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_love/screen/video_call/widget/body.dart';
import 'package:real_love/utils/sizeConfig.dart';

class VideoCallScreen extends StatefulWidget {
  final String idof_chanel;

  const VideoCallScreen({Key key, this.idof_chanel}) : super(key: key);
  @override
  _VideoState createState() => _VideoState();
}
class _VideoState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      body: VideoComponent(idOfChanel: widget.idof_chanel,)
    );
  }

}