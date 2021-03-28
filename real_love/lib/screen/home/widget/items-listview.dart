import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:real_love/model/usermatch/usermatch.dart';
import 'package:real_love/screen/home/widget/dialog_ofHome.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/utils/constant.dart';
import 'package:real_love/model/user/UserProfile/user-profile.dart';

class ItemsForHome extends StatefulWidget {
  final BuildContext context;
  final UserProfile document;
  final String currentUserId;

  ItemsForHome(this.context, this.document, this.currentUserId);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<ItemsForHome> with TickerProviderStateMixin {
  String uid;
  double buttonSize = 40.0;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    uid = user.uid;

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
                      padding: EdgeInsets.all(15.0),
                    ),
                    imageUrl: widget.document.url,
                    width: 80.0,
                    height: 80.0,
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
              SizedBox(width: 50,),
              GestureDetector(
                onTap: () {
                  print('1x');
                },
                child: Container(
                  child: LikeButton(
                    size: buttonSize,
                    circleColor: const CircleColor(
                        start: Color(0xfff21353), end: Color(0xffdb2923)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xfff21353),
                      dotSecondaryColor: Color(0xffdb2923),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.pink : Colors.black12,
                        size: buttonSize,
                      );
                    },
                    countBuilder: (int count, bool isLiked, String text) {
                      final ColorSwatch<int> color =
                      isLiked ? Colors.deepPurpleAccent : Colors.grey;
                      Widget result;
                      if (count == 0) {
                        result = Text(
                          'love',
                          style: TextStyle(color: color),
                        );
                      } else
                        result = Text(
                          text,
                          style: TextStyle(color: color),
                        );
                      return result;
                    },
                    likeCountPadding: const EdgeInsets.only(left: 15.0),
                    onTap: (isLiked) {
                      return changedata(
                        isLiked, context
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }

  void setusermatch({String uid, UserProfile user}) {
    FirebaseFirestore.instance.collection('list_user_match').doc(uid).collection(user.id).doc(user.id).set(
        user.toJson()
    );
    Future.delayed( Duration(seconds: 5), () {
      // deleayed code here
      //FirebaseFirestore.instance.collection('users_info').doc(user.id).delete();
    });
  }

}

Future<bool> changedata(bool status, BuildContext context) async {
  Future.delayed( Duration(seconds: 1), () {
    _showdialog(context);
    _sendRequestCouple();
  });
  return Future.value(!status);
}

void _sendRequestCouple() {
  /*FirebaseFirestore.instance.collection('info_call').doc(firebaseUser.uid).set({
    'call_to' : null,
    're_call' : null,
  });*/
}

Future<void> _showdialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog_ofHome();
    },
  );
}
