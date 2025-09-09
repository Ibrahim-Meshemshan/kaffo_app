import 'package:json_annotation/json_annotation.dart';

part 'get_user_adresses_repsonse.g.dart';

@JsonSerializable()
class GetUserAdressesRepsonse {
  num? id;
  num ?latitude;
  num ?longitude;
  String? city;
  String ?description;

  GetUserAdressesRepsonse({this.id, this.latitude, this.longitude, this.city, this.description});

  factory GetUserAdressesRepsonse.fromJson(Map<String, dynamic> json) => _$GetUserAdressesRepsonseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserAdressesRepsonseToJson(this);
}

