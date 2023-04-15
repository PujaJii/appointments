// To parse this JSON data, do
//
//     final todayListModel = todayListModelFromJson(jsonString);

import 'dart:convert';

TodayListModel todayListModelFromJson(String str) => TodayListModel.fromJson(json.decode(str));

String todayListModelToJson(TodayListModel data) => json.encode(data.toJson());

class TodayListModel {
  TodayListModel({
    this.response,
    this.data,
    this.responseMessage,
  });

  String? response;
  List<Appointments>? data;
  String? responseMessage;

  factory TodayListModel.fromJson(Map<String, dynamic> json) => TodayListModel(
    response: json["response"],
    data: json["data"] == null ? [] : List<Appointments>.from(json["data"]!.map((x) => Appointments.fromJson(x))),
    responseMessage: json["response_message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "response_message": responseMessage,
  };
}

class Appointments {
  Appointments({
    this.id,
    this.recipientName,
    this.meetingDate,
    this.meetingTime,
    this.meetingType,
    this.minutes,
    this.serviceId,
    this.videoConfaranceLink,
    this.meetingSubject,
    this.meetingDocuments,
    this.addedBy,
    this.editedBy,
    this.status,
    this.isSeen,
  });

  int? id;
  String? recipientName;
  DateTime? meetingDate;
  String? meetingTime;
  String? meetingType;
  String? minutes;
  String? serviceId;
  String? videoConfaranceLink;
  String? meetingSubject;
  String? meetingDocuments;
  String? addedBy;
  String? editedBy;
  int? status;
  int? isSeen;

  factory Appointments.fromJson(Map<String, dynamic> json) => Appointments(
    id: json["id"],
    recipientName: json["recipient_name"],
    meetingDate: json["meeting_date"] == null ? null : DateTime.parse(json["meeting_date"]),
    meetingTime: json["meeting_time"],
    meetingType: json["meeting_type"],
    minutes: json["minutes"],
    serviceId: json["serviceID"],
    videoConfaranceLink: json["video_confaranceLink"],
    meetingSubject: json["meeting_subject"],
    meetingDocuments: json["meeting_documents"],
    addedBy: json["added_by"],
    editedBy: json["edited_by"],
    status: json["status"],
    isSeen: json["is_seen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recipient_name": recipientName,
    "meeting_date": "${meetingDate!.year.toString().padLeft(4, '0')}-${meetingDate!.month.toString().padLeft(2, '0')}-${meetingDate!.day.toString().padLeft(2, '0')}",
    "meeting_time": meetingTime,
    "meeting_type": meetingType,
    "minutes": minutes,
    "serviceID": serviceId,
    "video_confaranceLink": videoConfaranceLink,
    "meeting_subject": meetingSubject,
    "meeting_documents": meetingDocuments,
    "added_by": addedBy,
    "edited_by": editedBy,
    "status": status,
    "is_seen": isSeen,
  };
}
