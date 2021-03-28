
import 'package:json_annotation/json_annotation.dart';

part 'listuser.g.dart';

@JsonSerializable()
class ListUser {
  num id;

  ListUser(this.id);
  factory ListUser.fromJson(Map<dynamic, dynamic> json) => (
      _$ListUserFromJson(json)
  );
  Map<String, dynamic> toJson() => _$ListUserToJson(this);
}