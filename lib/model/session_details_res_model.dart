// To parse this JSON data, do
//
//     final sessionDetailsResModel = sessionDetailsResModelFromJson(jsonString);

import 'dart:convert';

SessionDetailsResModel sessionDetailsResModelFromJson(String str) => SessionDetailsResModel.fromJson(json.decode(str));

String sessionDetailsResModelToJson(SessionDetailsResModel data) => json.encode(data.toJson());

class SessionDetailsResModel {
  final AttendanceSessionResponse? attendanceSessionResponse;

  SessionDetailsResModel({
    this.attendanceSessionResponse,
  });

  factory SessionDetailsResModel.fromJson(Map<String, dynamic> json) => SessionDetailsResModel(
    attendanceSessionResponse: json["AttendanceSessionResponse"] == null ? null : AttendanceSessionResponse.fromJson(json["AttendanceSessionResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "AttendanceSessionResponse": attendanceSessionResponse?.toJson(),
  };
}

class AttendanceSessionResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<LstAttendanceSessionDetail>? lstAttendanceSessionDetail;

  AttendanceSessionResponse({
    this.status,
    this.statusCode,
    this.message,
    this.lstAttendanceSessionDetail,
  });

  factory AttendanceSessionResponse.fromJson(Map<String, dynamic> json) => AttendanceSessionResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    lstAttendanceSessionDetail: json["lstAttendanceSessionDetail"] == null ? [] : List<LstAttendanceSessionDetail>.from(json["lstAttendanceSessionDetail"]!.map((x) => LstAttendanceSessionDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "lstAttendanceSessionDetail": lstAttendanceSessionDetail == null ? [] : List<dynamic>.from(lstAttendanceSessionDetail!.map((x) => x.toJson())),
  };
}

class LstAttendanceSessionDetail {
  final String? attendanceSessionId;
  final String? attendanceSessionValue;

  LstAttendanceSessionDetail({
    this.attendanceSessionId,
    this.attendanceSessionValue,
  });

  factory LstAttendanceSessionDetail.fromJson(Map<String, dynamic> json) => LstAttendanceSessionDetail(
    attendanceSessionId: json["AttendanceSession_Id"],
    attendanceSessionValue: json["AttendanceSession_Value"],
  );

  Map<String, dynamic> toJson() => {
    "AttendanceSession_Id": attendanceSessionId,
    "AttendanceSession_Value": attendanceSessionValue,
  };
}
