import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/utils/constant.dart';
import 'package:real_love/widget/input-text.dart';
class CustomDialog extends StatefulWidget {
  final String uid;

  const CustomDialog({Key key, this.uid}) : super(key: key);
  @override
  CustomDialogState createState() => CustomDialogState();

}
class CustomDialogState extends State<CustomDialog> {
  bool _selectedgame = false, _selectedmusic = false, _selectedsport = false, _selectedcat = false,
      _selecteddog = false, _selectedtravel = false;
  String game, music, sport, cat, dog, travel;
  int typechips;
  TextEditingController _controllerHometown, _controllerquote;

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(mounted){
        _controllerHometown = new TextEditingController();
        _controllerquote = new TextEditingController();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllerHometown.dispose();
    _controllerquote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(child: contentBox(context)),
      ),
    );
  }
  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3),offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InputTextField(label: 'Nơi ở ', isVis: false, controller: _controllerHometown,maxline: 3, minline: 1,),
                SizedBox(height: 10,),
                InputTextField(label: 'Giới thiệu', isVis: false, controller: _controllerquote,maxline: 5, minline: 3,),
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    'Hãy hoàn thành hồ sơ của bạn sẽ giúp bạn kết nối với những người thích hợp ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                SizedBox(height: 10,),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: <Widget>[
                    _buildChip(label: 'Game', color: Color(0xFFff6666), type: 1),
                    _buildChip(label: 'Music',color: Color(0xFF007f5c), type: 2),
                    _buildChip(label: 'Sport',color: Color(0xFF5f65d3), type: 3),
                    _buildChip(label: 'Cat',color: Color(0xFF19ca21), type: 4),
                    _buildChip(label: 'Dog',color: Color(0xFF60230b), type: 5),
                    _buildChip(label: 'Travel',color: Color(0xFFdea64b), type: 6),
                  ],
                ),
                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: (){
                        print('hometow : ${_controllerHometown.text}'
                            ', quoete : ${_controllerquote.text}, info : ${game}, ${music}, ${dog}, ${cat}, ${sport}, ${travel}');
                        if (_controllerquote.text.isEmpty || _controllerHometown.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Data must be entered in this field');
                        }else {
                          update_userinfo();
                        }
                      },
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Container(
                          color: Colors.white,
                        )),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.blueAccent,
                            ),
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset('assets/images/cafe-coffee.jpg')
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip({String label, Color color, int type}) {
    switch (type) {
      case 1 :
        return _buildinfoChips(selected1: _selectedgame, label: label, color: color, type: 1);
        break;
      case 2 :
        return _buildinfoChips(selected1: _selectedmusic, label: label, color: color, type: 2);
        break;
      case 3:
        return _buildinfoChips(selected1: _selectedsport, label: label, color: color, type: 3);
        break;
      case 4:
        return _buildinfoChips(selected1: _selectedcat, label: label, color: color, type: 4);
        break;
      case 5:
        return _buildinfoChips(selected1: _selecteddog, label: label, color: color, type: 5);
        break;
      case 6:
        return _buildinfoChips(selected1: _selectedtravel, label: label, color: color, type: 6);
        break;
    }

  }

  Widget _buildinfoChips({bool selected1, String label, Color color, int type}) {
    return FilterChip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Image.asset('assets/images/relove_gifyup.gif'),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      selected: selected1,
      selectedColor: Colors.purple,
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            switch (type) {
              case 1 :
                _selectedgame= selected;
                game = 'game';
                break;
              case 2:
                _selectedmusic = selected;
                music = 'music';
                break;
              case 3 :
                _selectedsport = selected;
                sport = 'sport';
                break;
              case 4 :
                _selectedcat = selected;
                cat = 'cat';
                break;
              case 5:
                _selecteddog = selected;
                dog = 'dog';
                break;
              case 6 :
                _selectedtravel = selected;
                travel = 'travel';
                break;
            }
            selected1 = selected;
          } else {
            switch (type) {
              case 1 :
                _selectedgame= selected;
                game = null;
                break;
              case 2:
                _selectedmusic = selected;
                music = null;
                break;
              case 3 :
                _selectedsport = selected;
                sport = null;
                break;
              case 4 :
                _selectedcat = selected;
                cat = null;
                break;
              case 5 :
                _selecteddog = selected;
                dog = null;
                break;
              case 6 :
                _selectedtravel = selected;
                travel = null;
                break;
            }
          }
        });
      },
    );
  }

  void update_userinfo() {
    print('xx ${_controllerHometown.text}, ${game}, ${widget.uid}');
    List<String> chips = [];
    chips.add(game);
    chips.add(music);
    chips.add(sport);
    chips.add(cat);
    chips.add(dog);
    chips.add(travel);
    FirebaseApi.updateuserinfo(hometown: _controllerHometown.text, quoete: _controllerquote.text, uid: widget.uid, chipss: chips);
  }
}