// To parse this JSON data, do
//
//     final mailCheckModel = mailCheckModelFromJson(jsonString);

import 'dart:convert';

MailCheckModel mailCheckModelFromJson(String str) => MailCheckModel.fromJson(json.decode(str));

String mailCheckModelToJson(MailCheckModel data) => json.encode(data.toJson());

class MailCheckModel {
  MailCheckModel({
    this.response,
    this.data,
    this.responseMessage,
  });

  String? response;
  Data? data;
  String? responseMessage;

  factory MailCheckModel.fromJson(Map<String, dynamic> json) => MailCheckModel(
    response: json["response"] == null ? null : json["response"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    responseMessage: json["response_message"] == null ? null : json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response,
    "data": data == null ? null : data!.toJson(),
    "response_message": responseMessage == null ? null : responseMessage,
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.provider,
    this.providerId,
    this.avatar,
    this.role,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic password;
  String? provider;
  String? providerId;
  String? avatar;
  String? role;
  dynamic rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    provider: json["provider"] == null ? null : json["provider"],
    providerId: json["provider_id"] == null ? null : json["provider_id"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    role: json["role"] == null ? null : json["role"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "provider": provider == null ? null : provider,
    "provider_id": providerId == null ? null : providerId,
    "avatar": avatar == null ? null : avatar,
    "role": role == null ? null : role,
    "remember_token": rememberToken,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
