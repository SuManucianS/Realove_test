// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infopalce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoPlace _$InfoPlaceFromJson(Map<String, dynamic> json) {
  return InfoPlace(
    json['id'] as num,
    json['name'] as String,
    json['palace'] as String,
    json['vote'] as int,
    json['path'] as String,
  );
}

Map<String, dynamic> _$InfoPlaceToJson(InfoPlace instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'palace': instance.palace,
      'vote': instance.vote,
      'path': instance.path,
    };
