// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Calling _$CallingFromJson(Map<String, dynamic> json) {
  return Calling(
    statecall: json['statecall'] as String,
    idUser: json['call_to'] as String,
    idtoUserReCall: json['re_call'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$CallingToJson(Calling instance) => <String, dynamic>{
      'call_to': instance.idUser,
      're_call': instance.idtoUserReCall,
      'id': instance.id,
      'statecall': instance.statecall,
    };
