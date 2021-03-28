import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:real_love/model/user/user-interes.dart';

class InteresProvider extends ChangeNotifier {
  InteresUserModel _interesUserModel;
  InteresUserModel get interesusermodel => _interesUserModel;
}