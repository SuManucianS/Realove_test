// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermatch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMatch _$UserMatchFromJson(Map<String, dynamic> json) {
  return UserMatch(
    nickname: json['nickname'] as String,
    photoUrl: json['photoUrl'] as String,
    id: json['id'] as String,
    createdAt: json['createdAt'] as String,
    chattingWith: json['chattingWith'] as String,
  );
}

Map<String, dynamic> _$UserMatchToJson(UserMatch instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'photoUrl': instance.photoUrl,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'chattingWith': instance.chattingWith,
    };
