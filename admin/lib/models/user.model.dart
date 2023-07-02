import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class UserModel {
  String? uid;
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.uid,
    this.username,
    this.password,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
