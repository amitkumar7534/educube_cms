import 'dart:convert';

class AttendenceModel {
  String? userId;
  bool? isPresent;
  String? attendanceId;
  String? catalogValueLeaveId;
  int? status;
  String? date;

  AttendenceModel({
    this.userId,
    this.isPresent,
    this.attendanceId,
    this.catalogValueLeaveId,
    this.status,
    this.date,
  });

  factory AttendenceModel.fromRawJson(String str) => AttendenceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendenceModel.fromJson(Map<String, dynamic> json) => AttendenceModel(
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
