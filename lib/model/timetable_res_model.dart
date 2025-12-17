

import 'dart:convert';

TimeTableResponseModel timeTableResponseModelFromJson(String str) =>
    TimeTableResponseModel.fromJson(json.decode(str));

String timeTableResponseModelToJson(TimeTableResponseModel data) =>
    json.encode(data.toJson());

class TimeTableResponseModel {
  final TimeTableResponse? timeTableResponse;

  TimeTableResponseModel({
    this.timeTableResponse,
  });

  factory TimeTableResponseModel.fromJson(Map<String, dynamic> json) =>
      TimeTableResponseModel(
        timeTableResponse: json["TimeTableResponse"] == null
            ? null
            : TimeTableResponse.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
    "TimeTableResponse": timeTableResponse?.toJson(),
  };
}

class TimeTableResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<TimeTableMaster>? lstGetTimeTableMaster;

  TimeTableResponse({
    this.status,
    this.statusCode,
    this.message,
    this.lstGetTimeTableMaster,
  });

  factory TimeTableResponse.fromJson(Map<String, dynamic> json) =>
      TimeTableResponse(
        status: json["Status"],
        statusCode: json["StatusCode"],
        message: json["Message"],
        lstGetTimeTableMaster: json["lstGetTimeTableMaster"] == null
            ? []
            : List<TimeTableMaster>.from(
            json["lstGetTimeTableMaster"]!.map((x) => TimeTableMaster.fromJson(x))
        ),
      );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "lstGetTimeTableMaster": lstGetTimeTableMaster == null
        ? []
        : List<dynamic>.from(lstGetTimeTableMaster!.map((x) => x.toJson())),
  };
}

class TimeTableMaster {
  final int? id;
  final String? lectureName;
  final String? session;
  final String? weekDay;
  final String? startTime;
  final String? endTime;
  final String? subjectName;
  final String? schoolName;
  final String? standard;
  final String? section;
  final int? year;
  final bool? isactive;
  final bool? isdeleted;

  TimeTableMaster({
    this.id,
    this.lectureName,
    this.session,
    this.weekDay,
    this.startTime,
    this.endTime,
    this.subjectName,
    this.schoolName,
    this.standard,
    this.section,
    this.year,
    this.isactive,
    this.isdeleted,
  });

  factory TimeTableMaster.fromJson(Map<String, dynamic> json) =>
      TimeTableMaster(
        id: json["id"],
        lectureName: json["lecture_name"],
        session: json["session"],
        weekDay: json["week_day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        subjectName: json["subject_name"],
        schoolName: json["school_name"],
        standard: json["standard"],
        section: json["section"],
        year: json["year"],
        isactive: json["isactive"],
        isdeleted: json["isdeleted"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lecture_name": lectureName,
    "session": session,
    "week_day": weekDay,
    "start_time": startTime,
    "end_time": endTime,
    "subject_name": subjectName,
    "school_name": schoolName,
    "standard": standard,
    "section": section,
    "year": year,
    "isactive": isactive,
    "isdeleted": isdeleted,
  };
}