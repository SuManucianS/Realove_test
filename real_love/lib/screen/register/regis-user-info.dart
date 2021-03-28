import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_love/model/image-object.dart';
import 'package:real_love/model/image/image-avatar.dart';
import 'package:real_love/model/user/user-interes.dart';
import 'package:real_love/provider/ProviderAvatar.dart';
import 'package:real_love/router/routing-name.dart';
import 'package:real_love/style/common-style.dart';
import 'package:real_love/style/component/background.dart';
import 'package:real_love/widget/avatar.dart';
import 'package:real_love/widget/button-submit.dart';
import 'package:real_love/widget/input-text.dart';

class RegisUserInfoScreen extends StatefulWidget{
  const RegisUserInfoScreen({Key key}) : super(key: key);
  @override
  RegisUserInfoState createState() => RegisUserInfoState();
}

class RegisUserInfoState extends State<RegisUserInfoScreen>{
  double sizeinfo;
  bool _sport, _readbook, _tourist, _playgame;
  int sport, readbook, tourist, playgame;
  String url;
  TextEditingController _controllerUsername, _controllerHometown, _controllerquote;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(mounted){
        _controllerUsername = new TextEditingController();
        _controllerHometown = new TextEditingController();
        _controllerquote = new TextEditingController();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerHometown.dispose();
    _controllerquote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sizeinfo = (MediaQuery.of(context).size.width - 70) / 3;
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPr(height: 260,),
          SingleChildScrollView(
            child: Stack(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 25),
                        child: SvgPicture.asset('assets/icons/relove_twoheart.svg', color: CommonStyle.colorWhite, height: 35,),
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text('Love', style: TextStyle(color: CommonStyle.colorWhite, fontWeight: FontWeight.bold),),
                      )
                    ],

                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30,),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            _buildInfo(sizeinfo, context),
                            Align(
                              alignment: Alignment.center,
                              child: _showAvatar(sizeinfo),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
  Widget _buildInfo(double sizeinfo, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: sizeinfo / 2),
      padding: EdgeInsets.only(left: 25, right: 25, top: sizeinfo / 2, bottom: 25),
      decoration: BoxDecoration(color: CommonStyle.colorWhite, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: InputTextField(label: 'Tên người dùng', isVis: false, controller: _controllerUsername,)
              ),
              SizedBox(height: 10),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: InputTextField(label: 'Quê quán', isVis: false, controller: _controllerHometown,)
              ),
              SizedBox(height: 10),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: InputTextField(label: 'Giới thiệu', isVis: false, controller: _controllerquote,)
              ),
              SizedBox(height: 20),
              _InteresWidget(title: 'Thể thao',
                link_gif1: 'assets/images/relove_gifyup.gif',
                link_gif2: 'assets/images/relove_gifnope.gif',
                tapped: _sport,
                interescategory: 1,
              ),
              Container(
                height: 1,
                color: CommonStyle.colorGrayBlue,
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
              SizedBox(height: 20),
              _InteresWidget(title: 'Đọc sách',
                link_gif1: 'assets/images/relove_gifyup.gif',
                link_gif2: 'assets/images/relove_gifnope.gif',
                tapped: _readbook,
                interescategory: 2,
              ),
              Container(
                height: 1,
                color: CommonStyle.colorGrayBlue,
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
              SizedBox(height: 20),
              _InteresWidget(title: 'Du lịch',
                link_gif1: 'assets/images/relove_gifyup.gif',
                link_gif2: 'assets/images/relove_gifnope.gif',
                tapped: _tourist,
                interescategory: 3,
              ),
              Container(
                height: 1,
                color: CommonStyle.colorGrayBlue,
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
              SizedBox(height: 20),
              _InteresWidget(title: 'Chơi game',
                link_gif1: 'assets/images/relove_gifyup.gif',
                link_gif2: 'assets/images/relove_gifnope.gif',
                tapped: _playgame,
                interescategory: 4,
              ),
              Container(
                height: 1,
                color: CommonStyle.colorGrayBlue,
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
              SizedBox(height: 30),
              ButtonWidget(text: 'SUBMIT', onTap: () {
                CreateUserInfo();
                Navigator.of(context).pushReplacementNamed(RoutingNameConstant.HomeRoute);
              },
              )
            ],
          ),
    );
  }

  Widget _InteresWidget ({ String title, String link_gif1, String link_gif2, bool tapped , int interescategory}){
    return Container(
          child: Column(
            children: [
              Container(
                child: Text(
                    title
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        check_selected(interescategory);
                      },
                      child: Container(
                          color: (tapped == null) ? CommonStyle.colorWhite :
                          (tapped ? Colors.deepPurpleAccent : CommonStyle.colorWhite),
                          child: Image.asset(link_gif1, height: 80,width: 80,)
                      ),
                    ),
                    SizedBox(width: 40,),
                    InkWell(
                      onTap: (){
                        check_nope(interescategory);
                      },
                      child: Container(
                          color: (tapped == null) ? CommonStyle.colorWhite :
                          (!tapped ? Colors.deepPurpleAccent : CommonStyle.colorWhite),
                          child: Image.asset(link_gif2, height: 80, width: 80,)
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
  }
  Widget _showAvatar(double sizeinfo) {
    return SizedBox(
      width: sizeinfo + 8,
      height: sizeinfo + 8,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: ClipOval(
                child: Container(
                  width: sizeinfo + 8,
                  height: sizeinfo + 8,
                  color: CommonStyle.colorWhite,
                ),
              )
          ),
          Align(
            alignment: Alignment.center,
            child: AvatarView(size: sizeinfo,),
          ),
        ],
      ),
    );
 }
 void CreateUserInfo(){
    FirebaseAuth _auth = FirebaseAuth.instance;
   final databaseReference = FirebaseDatabase.instance.reference();
   databaseReference.child("UserInfo").child('${_auth.currentUser?.uid}').update({
     'id' : _auth?.currentUser?.uid,
     'username' : _controllerUsername.text,
     'hometown' : _controllerHometown.text,
     'quote' : _controllerquote.text,
   });
 }

  void _updateImage() {
    print('upload');
  }


  void check_selected(int a) {
    switch(a){
      case 1:
        setState(() {
          _sport = true;
        });
        break;
      case 2:
        setState(() {
          _readbook = true;
        });
        break;
      case 3:
        setState(() {
          _tourist = true;
        });
        break;
      case 4 :
        setState(() {
          _playgame = true;
        });
        break;
    }
  }

  void check_nope(int interescategory) {
    switch(interescategory){
      case 1:
        setState(() {
          _sport = false;
        });
        break;
      case 2:
        setState(() {
          _readbook = false;
        });
        break;
      case 3:
        setState(() {
          _tourist = false;
        });
        break;
      case 4 :
        setState(() {
          _playgame = false;
        });
        break;
    }
  }
}
