import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_love/model/callingtoUser/calling.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/screen/home/home.dart';
import 'package:real_love/screen/match/couple-match.dart';
import 'package:real_love/screen/partner/partner.dart';
import 'package:real_love/screen/support/support.dart';
import 'package:real_love/screen/userprofile/user-profile.dart';
import 'package:real_love/screen/video_call/videocall.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/style/common-style.dart';

class DashboardHomePage extends StatefulWidget{
  final String currentUserId;
  DashboardHomePage({Key key, this.currentUserId}) : super(key: key);
  @override
  _DashboardHomePageState createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage>{
  int _selectedIndex = 0;
  bool calling1 = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<List<Calling>>(
      stream: FirebaseApi.getstatecall(),
      builder:(context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            ),
          );
        } else {
          final calling = snapshot.data;
          if (calling.isEmpty) {
            return Center(child: Text('nodata'),);
          } else {
            String id_ofrecall;
            calling.forEach((element) {
              if (element.id == widget.currentUserId) {
                if(element.idtoUserReCall != null) {
                    calling1 = true;
                  id_ofrecall = element.idtoUserReCall;
                } else {
                    calling1 = false;
                }
              }
            });
            return calling1 ? VideoCallScreen(idof_chanel: id_ofrecall,) :  Scaffold(
              body: _buildTabBody(context, _selectedIndex),
              bottomNavigationBar: _buildTabBar(context),
            );
          }
        }
      },);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
    });
  }
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Widget _buildTabBody(BuildContext context, index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return PartnerScreen(currentUserId: widget.currentUserId,);
      case 2:
        return MatchCouple(currentUserId: widget.currentUserId,);
      case 3:
        return SupportSrceen();
      case 4:
        return UserProfileScreen();
    }
    return SizedBox();
  }
  BottomNavigationBar _buildTabBar(BuildContext context){
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      unselectedItemColor: CommonStyle.colorGrayBlue,
      selectedItemColor: CommonStyle.colorPink,
      currentIndex: _selectedIndex,
      onTap: _onTapped,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      items: <BottomNavigationBarItem>[
        _buildBottomNavigationBarItem(context, 'assets/icons/relove_home.svg', 'Home'),
        _buildBottomNavigationBarItem(context, 'assets/icons/relove_message.svg', 'Message'),
        _buildBottomNavigationBarItem(context, 'assets/icons/relove_twoheart.svg', 'Match'),
        _buildBottomNavigationBarItem(context, 'assets/icons/relove_cafe.svg', 'Place'),
        _buildBottomNavigationBarItem(context, 'assets/icons/relove_me.svg', 'Me'),
      ],
    );
  }
  BottomNavigationBarItem _buildBottomNavigationBarItem(BuildContext context, String icon, String title){
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(icon, color: CommonStyle.colorGrayBlue, height: 20,),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(icon, color: CommonStyle.colorPink, height: 30,),
      ),
      label:'${title}'
    );
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}