import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/screen/home/component/auto_refesh.dart';
import 'package:real_love/model/user/UserProfile/user-profile.dart';
import 'package:real_love/screen/home/widget/Items_for_ListCouple.dart';
import 'package:real_love/screen/home/widget/items-listview.dart';
import 'package:real_love/screen/match/widget/itemsOfuser.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/style/common-style.dart';
import 'package:real_love/style/component/background.dart';
import 'package:real_love/utils/constant.dart';

class List_Couple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color.fromRGBO(239, 238, 239, 1.0),
      ),
      home: _ListCouple(),
    );
  }
}

class _ListCouple extends StatefulWidget {
  @override
  _ListCoupleState createState() =>
      new _ListCoupleState();
}

class _ListCoupleState extends State<_ListCouple> with TickerProviderStateMixin {
  final ScrollController listScrollController = ScrollController();
  String uid;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    uid = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    double sizeinfo = (MediaQuery.of(context).size.width - 70) / 3;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 50, left: 30),
                child: Image.asset('assets/gif/relove_giflove.gif', height: 50, width: 50,),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 50, left: 30),
                child: Image.asset('assets/gif/relove_giflove2.gif', height: 50, width: 50,),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 50, right: 30),
                child: Image.asset('assets/gif/relove_giflove.gif', height: 50, width: 50,),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: WillPopScope(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: StreamBuilder<List<UserProfile>>(
                            stream: FirebaseApi.getlistuser_match(limit: 10, uid: uid),
                            /*FirebaseFirestore.instance.collection('users').limit(_limit).snapshots()*/
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                                  ),
                                );
                              } else {
                                final usersmatch = snapshot.data;
                                if (usersmatch.isEmpty) {
                                  return Center(
                                    child: Text('nodata'),
                                  );
                                } else {
                                  return _buildInfo(
                                      sizeinfo: sizeinfo, context: context, size: size, usersmatch: usersmatch);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildInfo( {double sizeinfo, BuildContext context, Size size, List<UserProfile> usersmatch}) {
    return Container(
      height: size.height,
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
      ),
      child: AutoRefresh(
        duration: const Duration(milliseconds: 2000),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 44.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onLongPress: () {
                          },
                          child: ItemsForCouple(context, usersmatch[index], '123'),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: usersmatch.length,
                controller: listScrollController,
              ),
            ),
          ),
        ),
      ),
    );
  }
}