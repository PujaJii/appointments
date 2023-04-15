// To parse this JSON data, do
//
//     final logHistoryModel = logHistoryModelFromJson(jsonString);

import 'dart:convert';

LogHistoryModel logHistoryModelFromJson(String str) => LogHistoryModel.fromJson(json.decode(str));

String logHistoryModelToJson(LogHistoryModel data) => json.encode(data.toJson());

class LogHistoryModel {
  LogHistoryModel({
    this.response,
    this.data,
    this.responseMessage,
  });

  String? response;
  List<LogHistoryList>? data;
  String? responseMessage;

  factory LogHistoryModel.fromJson(Map<String, dynamic> json) => LogHistoryModel(
    response: json["response"] == null ? null : json["response"],
    data: json["data"] == null ? null : List<LogHistoryList>.from(json["data"].map((x) => LogHistoryList.fromJson(x))),
    responseMessage: json["response_message"] == null ? null : json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "response_message": responseMessage == null ? null : responseMessage,
  };
}

class LogHistoryList {
  LogHistoryList({
    this.id,
    this.ipAddress,
    this.role,
    this.loginTime,
    this.userAgent,
  });

  int? id;
  String? ipAddress;
  Role? role;
  DateTime? loginTime;
  String? userAgent;

  factory LogHistoryList.fromJson(Map<String, dynamic> json) => LogHistoryList(
    id: json["id"] == null ? null : json["id"],
    ipAddress: json["ip_address"] == null ? null : json["ip_address"],
    role: json["role"] == null ? null : roleValues.map[json["role"]],
    loginTime: json["loginTime"] == null ? null : DateTime.parse(json["loginTime"]),
    userAgent: json["userAgent"] == null ? null : json["userAgent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "ip_address": ipAddress == null ? null : ipAddress,
    "role": role == null ? null : roleValues.reverse![role],
    "loginTime": loginTime == null ? null : loginTime!.toIso8601String(),
    "userAgent": userAgent == null ? null : userAgent,
  };
}

enum Role { PA, DM }

final roleValues = EnumValues({
  "DM": Role.DM,
  "PA": Role.PA
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
