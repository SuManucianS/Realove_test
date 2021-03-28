
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/screen/match/widget/itemsOfuser.dart';
import 'package:real_love/screen/partner/widget/item.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/style/common-style.dart';
import 'package:real_love/style/component/background.dart';
import 'package:real_love/model/usermatch/usermatch.dart';
import 'package:real_love/utils/constant.dart';
import 'package:real_love/model/user/UserProfile/user-profile.dart';

class MatchCouple extends StatefulWidget {
  final String currentUserId;

  const MatchCouple({Key key, this.currentUserId}) : super(key: key);
  @override
  MatchCoupleState createState() => MatchCoupleState();
}

class MatchCoupleState extends State<MatchCouple> {
  int _limit = 15;
  final ScrollController listScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double sizeinfo = (MediaQuery.of(context).size.width - 70) / 3;
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundPr(
              height: size.height/1.6,
            ),
            Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
              color: Colors.white,
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
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 250, horizontal: 30,),
                child: WillPopScope(
                  child: Stack(
                    children: <Widget>[
                      Container(
                          child: StreamBuilder<List<UserProfile>>(
                            stream: FirebaseApi.getinfouser(limit: 10),
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
                                  return Center(child: Text('nodata'),);
                                }
                                else {
                                  return _buildInfo(sizeinfo: sizeinfo, context: context, size: size, usersmatch: usersmatch);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                  ),
                )
                /*Column(
                  children: [
                    *//*_buildInfo(sizeinfo: sizeinfo, context: context, size: size),*//*
                  ],*/
                ),
              ),
          ],
        ),
      ),
    );
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
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ItemsOfUserMatch(context, usersmatch[index], widget.currentUserId);
        },
        itemCount: usersmatch.length,
        controller: listScrollController,
      ),
    );
  }

}