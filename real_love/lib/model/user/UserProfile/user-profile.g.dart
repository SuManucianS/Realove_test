// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    hometown: json['hometown'] as String,
    quote: json['quote'] as String,
    id: json['id'] as String,
    url: json['url'] as String,
    username: json['username'] as String,
    chips: json['chips'] as List,
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'hometown': instance.hometown,
      'quote': instance.quote,
      'id': instance.id,
      'url': instance.url,
      'username': instance.username,
      'chips': instance.chips,
    };
