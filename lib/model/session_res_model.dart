// To parse this JSON data, do
//
//     final sessionResModel = sessionResModelFromJson(jsonString);

import 'dart:convert';

SessionResModel sessionResModelFromJson(String str) => SessionResModel.fromJson(json.decode(str));

String sessionResModelToJson(SessionResModel data) => json.encode(data.toJson());

class SessionResModel {
  final SectionResponse? sectionResponse;

  SessionResModel({
    this.sectionResponse,
  });

  factory SessionResModel.fromJson(Map<String, dynamic> json) => SessionResModel(
    sectionResponse: json["SectionResponse"] == null ? null : SectionResponse.fromJson(json["SectionResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "SectionResponse": sectionResponse?.toJson(),
  };
}

class SectionResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final dynamic lstSectionDetail;

  SectionResponse({
    this.status,
    this.statusCode,
    this.message,
    this.lstSectionDetail,
  });

  factory SectionResponse.fromJson(Map<String, dynamic> json) => SectionResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    lstSectionDetail: json["lstSectionDetail"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "lstSectionDetail": lstSectionDetail,
  };
}
