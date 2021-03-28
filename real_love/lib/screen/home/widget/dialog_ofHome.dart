
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/utils/constant.dart';
import 'package:real_love/widget/input-text.dart';

class Dialog_ofHome extends StatefulWidget {
  final String uid;

  const Dialog_ofHome({Key key, this.uid}) : super(key: key);
  @override
  CustomDialogState createState() => CustomDialogState();

}
class CustomDialogState extends State<Dialog_ofHome> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Constants.padding),
    ),
      title: Center(
        child: Text('Gửi yêu cầu kết đôi thành công', style: TextStyle(
          fontFamily: 'DancingScript'
        ),),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/relove_successicon.svg', height: 50, width:  50,),
          SizedBox(height: 10,),
          Text('Request Success', style: TextStyle(
              fontFamily: 'DancingScript',
            color: Colors.grey
          ),),
          SizedBox(height: 10,),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Container()
              ),
              SizedBox(width: 30,),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constants.padding),
                        color: Colors.blueAccent
                    ),
                    child: Text('OK', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  ),
                ),
              ),
            ],

          )
        ]
      ),
    );
  }

}