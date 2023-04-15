// To parse this JSON data, do
//
//     final acceptAppointmentModel = acceptAppointmentModelFromJson(jsonString);

import 'dart:convert';

AcceptAppointmentModel acceptAppointmentModelFromJson(String str) => AcceptAppointmentModel.fromJson(json.decode(str));

String acceptAppointmentModelToJson(AcceptAppointmentModel data) => json.encode(data.toJson());

class AcceptAppointmentModel {
  AcceptAppointmentModel({
    this.response,
    this.responseMessage,
  });

  String? response;
  String? responseMessage;

  factory AcceptAppointmentModel.fromJson(Map<String, dynamic> json) => AcceptAppointmentModel(
    response: json["response"] == null ? null : json["response"],
    responseMessage: json["response_message"] == null ? null : json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response,
    "response_message": responseMessage == null ? null : responseMessage,
  };
}
