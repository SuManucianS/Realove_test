
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:real_love/model/image/image-avatar.dart';

class AvatarImageProvider extends ChangeNotifier {
  AvatarImage _avatarImage;
  String get avatarimageurl => _avatarImage.url_image;
  void do_url(String url){
    print('122xx');
    _avatarImage?.url_image = url;
    notifyListeners();
  }
}