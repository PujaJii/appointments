// To parse this JSON data, do
//
//     final deleteModel = deleteModelFromJson(jsonString);

import 'dart:convert';

DeleteModel deleteModelFromJson(String str) => DeleteModel.fromJson(json.decode(str));

String deleteModelToJson(DeleteModel data) => json.encode(data.toJson());

class DeleteModel {
  DeleteModel({
    this.response,
    this.responseMessage,
  });

  String? response;
  String? responseMessage;

  factory DeleteModel.fromJson(Map<String, dynamic> json) => DeleteModel(
    response: json["response"],
    responseMessage: json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "response_message": responseMessage,
  };
}
