// To parse this JSON data, do
//
//     final attendanceResModel = attendanceResModelFromJson(jsonString);

import 'dart:convert';

AttendanceResModel attendanceResModelFromJson(String str) => AttendanceResModel.fromJson(json.decode(str));

String attendanceResModelToJson(AttendanceResModel data) => json.encode(data.toJson());

class AttendanceResModel {
  final AttendanceResponse? attendanceResponse;

  AttendanceResModel({
    this.attendanceResponse,
  });

  factory AttendanceResModel.fromJson(Map<String, dynamic> json) => AttendanceResModel(
    attendanceResponse: json["AttendanceResponse"] == null ? null : AttendanceResponse.fromJson(json["AttendanceResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "AttendanceResponse": attendanceResponse?.toJson(),
  };
}

class AttendanceResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final AttUserDetails? attUserDetails;
  final List<AttendanceDetail>? attendanceDetails;
  final List<HolidayDetail>? holidayDetails;

  AttendanceResponse({
    this.status,
    this.statusCode,
    this.message,
    this.attUserDetails,
    this.attendanceDetails,
    this.holidayDetails,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) => AttendanceResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    attUserDetails: json["Att_UserDetails"] == null ? null : AttUserDetails.fromJson(json["Att_UserDetails"]),
    attendanceDetails: json["AttendanceDetails"] == null ? [] : List<AttendanceDetail>.from(json["AttendanceDetails"]!.map((x) => AttendanceDetail.fromJson(x))),
    holidayDetails: json["HolidayDetails"] == null ? [] : List<HolidayDetail>.from(json["HolidayDetails"]!.map((x) => HolidayDetail.fromJson(x))),
  );



  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "Att_UserDetails": attUserDetails?.toJson(),
    "AttendanceDetails": attendanceDetails == null ? [] : List<dynamic>.from(attendanceDetails!.map((x) => x.toJson())),
    "HolidayDetails": holidayDetails == null ? [] : List<dynamic>.from(holidayDetails!.map((x) => x.toJson())),
  };
}

class AttUserDetails {
  final String? userId;
  final String? name;
  final String? addmissionDate;
  final String? dateOfJoining;
  final String? dateOfRetirement;

  AttUserDetails({
    this.userId,
    this.name,
    this.addmissionDate,
    this.dateOfJoining,
    this.dateOfRetirement,
  });

  factory AttUserDetails.fromJson(Map<String, dynamic> json) => AttUserDetails(
    userId: json["user_id"],
    name: json["name"],
    addmissionDate: json["addmission_date"],
    dateOfJoining: json["date_of_joining"],
    dateOfRetirement: json["date_of_retirement"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "addmission_date": addmissionDate,
    "date_of_joining": dateOfJoining,
    "date_of_retirement": dateOfRetirement,
  };
}

class AttendanceDetail {
  final String? userId;
  final bool? isPresent;
  final String? attendanceId;
  final String? catalogValueLeaveId;
  final int? status;
  final String? date;

  AttendanceDetail({
    this.userId,
    this.isPresent,
    this.attendanceId,
    this.catalogValueLeaveId,
    this.status,
    this.date,
  });

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) => AttendanceDetail(
    userId: json["user_id"],
    isPresent: json["is_present"],
    attendanceId: json["attendance_id"],
    catalogValueLeaveId: json["catalog_value_leave_id"],
    status: json["status"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "is_present": isPresent,
    "attendance_id": attendanceId,
    "catalog_value_leave_id": catalogValueLeaveId,
    "status": status,
    "date": date,
  };
}

class HolidayDetail {
  final int? dateDay;

  HolidayDetail({
    this.dateDay,
  });

  factory HolidayDetail.fromJson(Map<String, dynamic> json) => HolidayDetail(
    dateDay: json["date_day"],
  );

  Map<String, dynamic> toJson() => {
    "date_day": dateDay,
  };
}
