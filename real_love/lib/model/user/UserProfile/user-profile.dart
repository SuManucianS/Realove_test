import 'package:json_annotation/json_annotation.dart';
part 'user-profile.g.dart';

@JsonSerializable()
class UserProfile {
  String hometown;
  String quote;
  String id;
  String url;
  String username;
  List chips;

  UserProfile({this.hometown, this.quote, this.id,  this.url, this.username, this.chips});


  static UserProfile fromJson(Map<dynamic, dynamic> json) => (
      _$UserProfileFromJson(json)
  );
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

}