// To parse this JSON data, do
//
//     final createAppointmentModel = createAppointmentModelFromJson(jsonString);

import 'dart:convert';

CreateAppointmentModel createAppointmentModelFromJson(String str) => CreateAppointmentModel.fromJson(json.decode(str));

String createAppointmentModelToJson(CreateAppointmentModel data) => json.encode(data.toJson());

class CreateAppointmentModel {
  CreateAppointmentModel({
    this.response,
    this.responseMessage,
  });

  String? response;
  String? responseMessage;

  factory CreateAppointmentModel.fromJson(Map<String, dynamic> json) => CreateAppointmentModel(
    response: json["response"] == null ? null : json["response"],
    responseMessage: json["response_message"] == null ? null : json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response,
    "response_message": responseMessage == null ? null : responseMessage,
  };
}
