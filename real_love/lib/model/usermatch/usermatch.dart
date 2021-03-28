import 'package:json_annotation/json_annotation.dart';
part 'usermatch.g.dart';

@JsonSerializable()
class UserMatch {
  final String nickname;
  final String photoUrl;
  final String id;
  final String createdAt;
  final String chattingWith;

  const UserMatch({this.nickname, this.photoUrl, this.id, this.createdAt, this.chattingWith});

  UserMatch copyWith({
    String nickname,
    String photoUrl,
    String id,
    String createdAt,
    String chattingWith
  }) =>
      UserMatch(
        nickname: nickname ?? this.nickname,
        photoUrl: photoUrl ?? this.photoUrl,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        chattingWith: chattingWith ?? this.chattingWith
      );

  static UserMatch fromJson(Map<dynamic, dynamic> json) => (
      _$UserMatchFromJson(json)
  );
  Map<String, dynamic> toJson() => _$UserMatchToJson(this);
}