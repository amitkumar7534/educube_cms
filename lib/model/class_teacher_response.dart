import 'dart:convert';

ClassTeachersResModel classTeachersResModelFromJson(String str) =>
    ClassTeachersResModel.fromJson(json.decode(str));

class ClassTeachersResModel {
  ClassTeachersResModel({required this.classTeacherResponse});

  final ClassTeacherResponse? classTeacherResponse;

  factory ClassTeachersResModel.fromJson(Map<String, dynamic> json) {
    return ClassTeachersResModel(
      classTeacherResponse: json['SubjectWiseAssignTeachersResponse'] == null
          ? null
          : ClassTeacherResponse.fromJson(
        Map<String, dynamic>.from(json['SubjectWiseAssignTeachersResponse']),
      ),
    );
  }
}

class ClassTeacherResponse {
  ClassTeacherResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.lstSwTeacherDetails,
  });

  final bool? status;
  final int? statusCode;
  final String? message;
  final List<LstSwTeacherDetail> lstSwTeacherDetails;

  factory ClassTeacherResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['lstSWTeacherDetails'] ??
        json['lstSWTeacherDetails'] ??
        []) as List;
    return ClassTeacherResponse(
      status: json['Status'] ?? json['status'],
      statusCode: json['StatusCode'] ?? json['statusCode'],
      message: json['Message'] ?? json['message'],
      lstSwTeacherDetails: list
          .map((e) => LstSwTeacherDetail.fromJson(
        Map<String, dynamic>.from(e as Map),
      ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Status': status,
    'StatusCode': statusCode,
    'Message': message,
    'lstSwTeacherDetails':
    lstSwTeacherDetails.map((e) => e.toJson()).toList(),
  };
}

class LstSwTeacherDetail {
  LstSwTeacherDetail({
    required this.className,
    required this.section,
    required this.subject,
    required this.employeeName,
    required this.employeeStatus,
  });

  final String? className; // maps JSON key "Class"/"class"
  final String? section;
  final String? subject;
  final String? employeeName;
  final String? employeeStatus;

  factory LstSwTeacherDetail.fromJson(Map<String, dynamic> json) {
    return LstSwTeacherDetail(
      className: json['Class'] ?? json['class'],
      section: json['Section'] ?? json['section'],
      subject: json['Subject'] ?? json['subject'],
      employeeName: json['EmployeeName'] ?? json['employeeName'],
      employeeStatus: json['EmployeeStatus'] ?? json['employeeStatus'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Class' : className,
    'Section': section,
    'Subject': subject,
    'EmployeeName': employeeName,
    'EmployeeStatus': employeeStatus,
  };
}
