import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user-interes.g.dart';

@JsonSerializable()
class InteresUserModel {
  bool rating;
  InteresUserModel({ this.rating});
  factory InteresUserModel.fromJson(Map<String, dynamic> json) => _$InteresUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$InteresUserModelToJson(this);

  @override
  String toString() {
    return 'rating : ${rating}';
  }
}