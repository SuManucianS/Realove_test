import 'package:json_annotation/json_annotation.dart';

part 'infopalce.g.dart';

@JsonSerializable()
class InfoPlace{
  num id;
  String name;
  String palace;
  int vote;
  String path;


  InfoPlace(this.id, this.name, this.palace, this.vote, this.path);

  factory InfoPlace.fromJson(Map<String, dynamic> json) => _$InfoPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$InfoPlaceToJson(this);
}