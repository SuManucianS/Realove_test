import 'package:flutter/cupertino.dart';
import 'package:real_love/model/user/UserProfile/user-profile.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile _userprofile;
  UserProfile get userprofile => _userprofile;

  Future<String> getAvatarImg () async {
    notifyListeners();
    return _userprofile.url;
  }
}