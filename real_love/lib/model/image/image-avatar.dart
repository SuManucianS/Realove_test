import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AvatarImage extends ChangeNotifier{
  String filename;
  String url_image;
  AvatarImage({ @required this.filename, @required this.url_image });
  void do_url(String url){
    url_image = url;
    notifyListeners();
  }
}