// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) => ServiceListModel.fromJson(json.decode(str));

String serviceListModelToJson(ServiceListModel data) => json.encode(data.toJson());

class ServiceListModel {
  ServiceListModel({
    this.response,
    this.data,
    this.responseMessage,
  });

  String? response;
  List<Services>? data;
  String? responseMessage;

  factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
    response: json["response"] == null ? null : json["response"],
    data: json["data"] == null ? null : List<Services>.from(json["data"].map((x) => Services.fromJson(x))),
    responseMessage: json["response_message"] == null ? null : json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "response_message": responseMessage == null ? null : responseMessage,
  };
}

class Services {
  Services({
    this.id,
    this.serviceName,
    this.accessToken,
    this.status,
  });

  int? id;
  String? serviceName;
  String? accessToken;
  int? status;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["service_name"] == null ? null : json["service_name"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "service_name": serviceName == null ? null : serviceName,
    "access_token": accessToken == null ? null : accessToken,
    "status": status == null ? null : status,
  };
}
