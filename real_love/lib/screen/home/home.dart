
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/screen/home/component/auto_refesh.dart';
import 'package:real_love/model/user/UserProfile/user-profile.dart';
import 'package:real_love/screen/home/layout/ListCouple.dart';
import 'package:real_love/screen/home/widget/items-listview.dart';
import 'package:real_love/screen/match/widget/itemsOfuser.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/style/common-style.dart';
import 'package:real_love/style/component/background.dart';
import 'package:real_love/utils/constant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color.fromRGBO(239, 238, 239, 1.0),
      ),
      home: _InputChipExample(),
    );
  }
}

class _InputChipExample extends StatefulWidget {
  @override
  _InputChipExampleState createState() =>
      new _InputChipExampleState();
}

class _InputChipExampleState extends State<_InputChipExample> with TickerProviderStateMixin {
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
          BackgroundPr(
            height: size.height / 1.6,
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(right: 250, left: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.padding),
                border: Border.all(color: Colors.pink.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(color: Colors.pink.withOpacity(0.2),offset: Offset(0,0),
                        blurRadius: 10
                    ),
                  ]
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => List_Couple())
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset('assets/icons/relove_couple.svg', color: CommonStyle.colorWhite, height: 35,),
                    ),
                    SizedBox(width: 5, ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Couple', style: TextStyle(color: CommonStyle.colorWhite, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            ),
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
                        child: ItemsForHome(context, usersmatch[index], '123'),
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