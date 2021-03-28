// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Avatar _$AvatarFromJson(Map<String, dynamic> json) {
  return Avatar(
    indexAvatar: json['indexAvatar'] as int,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'indexAvatar': instance.indexAvatar,
      'images': instance.images,
    };
