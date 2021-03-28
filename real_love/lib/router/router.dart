import 'package:flutter/material.dart';
import 'package:real_love/router/routing-name.dart';
import 'package:real_love/screen/layout/dashboard.dart';
import 'package:real_love/screen/login/login.dart';
import 'file:///D:/DoAn_2020_vuVanSu/Real_Love/real_love/lib/screen/register/regis-user-info.dart';
import 'package:real_love/screen/userprofile/user-profile.dart';

abstract class RoutesConstant {
  static final routes = <String, WidgetBuilder>{
    RoutingNameConstant.HomeRoute: (BuildContext context) => new DashboardHomePage(),
    RoutingNameConstant.UserProfile: (BuildContext context) => new UserProfileScreen(),
    RoutingNameConstant.Login: (BuildContext context) => new LoginScreen(),
    RoutingNameConstant.regisUserInfo: (BuildContext context) => new RegisUserInfoScreen()
  };
}