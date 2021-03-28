import 'package:json_annotation/json_annotation.dart';
part 'calling.g.dart';

@JsonSerializable()
class Calling {
  final String idUser;
  final String idtoUserReCall;
  final String id;
  final String statecall;

  const Calling({this.statecall,this.idUser, this.idtoUserReCall,this.id});

  static Calling fromJson(Map<dynamic, dynamic> json) => (
      _$CallingFromJson(json)
  );
  Map<String, dynamic> toJson() => _$CallingToJson(this);
}