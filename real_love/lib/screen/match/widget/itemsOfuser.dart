import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_love/model/usermatch/usermatch.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/utils/constant.dart';
import 'package:real_love/model/user/UserProfile/user-profile.dart';

class ItemsOfUserMatch extends StatefulWidget {
  final BuildContext context;
  final UserProfile document;
  final String currentUserId;

  ItemsOfUserMatch(this.context, this.document, this.currentUserId);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<ItemsOfUserMatch> with TickerProviderStateMixin {
  AnimationController _animationController;
  double _containerPaddingLeft = 20.0;
  double _animationValue;
  double _translateX = 0;
  double _translateY = 0;
  double _rotate = 0;
  double _scale = 1;
  String uid;
  bool show;
  bool sent = false;
  Color _color = Colors.lightBlue;


  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    uid = user.uid;
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1300));
    show = true;
    _animationController.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController.value;
        if (_animationValue >= 0.2 && _animationValue < 0.4) {
          _containerPaddingLeft = 100.0;
          _color = Colors.white;
        } else if (_animationValue >= 0.4 && _animationValue <= 0.5) {
          _translateX = 80.0;
          _rotate = -20.0;
          _scale = 0.1;
        } else if (_animationValue >= 0.5 && _animationValue <= 0.8) {
          _translateY = -20.0;
        } else if (_animationValue >= 0.81) {
          _containerPaddingLeft = 20.0;
          sent = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.document.id == uid) {
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Material(
                  child: widget.document.url != null
                      ? CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                            ),
                            width: 50.0,
                            height: 50.0,
                            padding: EdgeInsets.all(15.0),
                          ),
                          imageUrl: widget.document.url,
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.account_circle,
                          size: 50.0,
                          color: greyColor,
                        ),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  clipBehavior: Clip.hardEdge,
                ),
              ),
              Flexible(
                flex: 8,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${widget.document.username}',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/relove_place.svg',
                            height: 15,
                            width: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${widget.document.hometown}',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(left: 10.0),
                ),
              ),
              SizedBox(width: 20,),
              Flexible(
                flex: 6,
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      _animationController.forward();
                      setusermatch(uid: uid, user: widget.document);
                    },
                    child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color: _color,
                          borderRadius: BorderRadius.circular(100.0),
                          boxShadow: [
                            BoxShadow(
                              color: _color,
                              blurRadius: 21,
                              spreadRadius: -15,
                              offset: Offset(
                                0.0,
                                20.0,
                              ),
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            (!sent)
                                ? AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    child: Icon(Icons.fast_forward, color: Colors.pinkAccent,),
                                    curve: Curves.fastOutSlowIn,
                                    transform: Matrix4.translationValues(_translateX, _translateY, 0)
                                      ..rotateZ(_rotate)
                                      ..scale(_scale),
                                  )
                                : Container(),
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 600),
                              child: show ? SizedBox(width: 10.0) : Container(),
                            ),
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 200),
                              child: show ? Text("Match", style: TextStyle(color: Colors.white),) : Container(),
                            ),
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 200),
                              child: sent ? Icon(Icons.favorite, color: Colors.red,) : Container(),
                            ),
                            AnimatedSize(
                              vsync: this,
                              alignment: Alignment.topLeft,
                              duration: Duration(milliseconds: 600),
                              child: sent ? SizedBox(width: 10.0) : Container(),
                            ),
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 200),
                              child: sent ? Text("Ok", style: TextStyle(color: Colors.pinkAccent),) : Container(),
                            ),
                          ],
                        )),
                  ),
                ),
              ),

              /*Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: Center(
                                child: GestureDetector(
                                    onTap: () {

                                    },

                      ],
                    ),
                  ),*/
            ],
          ),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }

  void setusermatch({String uid, UserProfile user}) {
    FirebaseFirestore.instance.collection('list_user_match').doc(uid).collection(uid).doc(user.id).set(
      user.toJson()
    );
    Future.delayed( Duration(seconds: 5), () {
      // deleayed code here
      //FirebaseFirestore.instance.collection('users_info').doc(user.id).delete();
    });
  }
}
