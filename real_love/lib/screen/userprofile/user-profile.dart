import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/screen/userprofile/widget/dialog.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/style/common-style.dart';
import 'package:real_love/model/user/UserProfile/user-profile.dart';
import 'package:real_love/style/component/background.dart';
import 'package:real_love/utils/constant.dart';
import 'package:real_love/widget/avatar.dart';
import 'package:real_love/widget/button-submit.dart';
import 'package:real_love/widget/input-text.dart';

class UserProfileScreen extends StatefulWidget{
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileScreen>{
  double sizeinfo;
  int sport, readbook, tourist, playgame;

  String url;
  UserProfile _userinfo;
  String uid;
  TextEditingController _controllerUsername, _controllerHometown, _controllerquote;
  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    uid = user.uid;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(mounted){
        _controllerUsername = new TextEditingController();
        _controllerHometown = new TextEditingController();
        _controllerquote = new TextEditingController();
        /*FirebaseAuth _auth = FirebaseAuth.instance;
        final databaseReference = FirebaseDatabase.instance.reference();
        databaseReference.child("UserInfo").child('${_auth.currentUser?.uid}').once().then((DataSnapshot snapshot) {
          setState(() {
            print('${snapshot.value}');
            _userinfo = UserProfile.fromJson(snapshot.value);
            _controllerUsername.text = _userinfo.username;
            _controllerquote.text = _userinfo.quote;
            _controllerHometown.text = _userinfo.hometown;
            url = _userinfo.url;
          });
        });*/
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder<List<UserProfile>>(
        stream: FirebaseApi.getinfouser(limit: 10),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ),
            );
          } else {
            final userprofile = snapshot.data;
            if (userprofile.isEmpty) {
              return Center(child: Text('nodata'),);
            } else {
              bool ok;
              userprofile.forEach((element) {
                if (element.id == uid) {
                  if (element.chips.isEmpty){
                    ok = true;
                  } else {
                    ok = false;
                    _controllerUsername.text = element.username;
                    _controllerquote.text = element.quote;
                    _controllerHometown.text = element.hometown;
                    url = element.url;
                  }
                }
              });
              return ok ? CustomDialog(uid: uid,) : _buildMe();
            }
          }
        },
      ),
    );
  }
  Widget _buildMe () {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                BackgroundPr(
                  height: 260,
                ),
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
                            _buildInfo(sizeinfo: sizeinfo, context: context),
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
      ),
    );
  }

  Widget _buildInfo({ double sizeinfo, BuildContext context }) {
    return Container(
      margin: EdgeInsets.only(top: sizeinfo / 2),
      padding: EdgeInsets.only(left: 25, right: 25, top: sizeinfo / 2, bottom: 25),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(Constants.padding),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3),offset: Offset(0,10),
                blurRadius: 10
            ),
          ]
        /*
        color: CommonStyle.colorWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),*/
      ),
      child: Column(
        children: [
          SizedBox(height: 50,),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: InputTextField(label: 'Tên người dùng', isVis: false, controller: _controllerUsername)
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
              child: InputTextField(label: 'Giới thiệu', isVis: false, controller: _controllerquote,maxline: 5,)
          ),
          SizedBox(height: 30),
          ButtonWidget(text: 'SUBMIT', onTap: () {
            updatetoinfo();
          },
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
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AvatarView(size: sizeinfo, url: url,),
          ),
        ],
      ),
    );
  }

  void updatetoinfo() {
    FirebaseFirestore.instance.collection('users_info').doc(uid).update({
      'hometown' : _controllerHometown.text,
      'quote' : _controllerquote.text,
      'username' : _controllerUsername.text
    });
  }



}

