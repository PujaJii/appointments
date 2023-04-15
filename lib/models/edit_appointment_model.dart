// To parse this JSON data, do
//
//     final editApiModel = editApiModelFromJson(jsonString);

import 'dart:convert';

EditApiModel editApiModelFromJson(String str) => EditApiModel.fromJson(json.decode(str));

String editApiModelToJson(EditApiModel data) => json.encode(data.toJson());

class EditApiModel {
  EditApiModel({
    this.response,
    this.responseMessage,
  });

  String? response;
  String? responseMessage;

  factory EditApiModel.fromJson(Map<String, dynamic> json) => EditApiModel(
    response: json["response"],
    responseMessage: json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "response_message": responseMessage,
  };
}
