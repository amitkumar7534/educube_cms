import 'dart:convert';

TeacherDetailsResModel teacherDetailsResModelFromJson(String str) =>
    TeacherDetailsResModel.fromJson(json.decode(str));

class TeacherDetailsResModel {
  TeacherDetailsResModel({required this.teacherDetailsResponse});

  final TeacherDetailsResponse? teacherDetailsResponse;

  factory TeacherDetailsResModel.fromJson(Map<String, dynamic> json) {
    return TeacherDetailsResModel(
      teacherDetailsResponse: json['ClassSectionAssignTeachersResponse'] == null
          ? null
          : TeacherDetailsResponse.fromJson(
        Map<String, dynamic>.from(json['ClassSectionAssignTeachersResponse']),
      ),
    );
  }
}

class TeacherDetailsResponse {
  TeacherDetailsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.lstTeacherDetails,
  });

  final bool? status;
  final int? statusCode;
  final String? message;
  final List<TeacherDetail> lstTeacherDetails;

  factory TeacherDetailsResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['lstTeacherDetails'] ??
        json['lst_teacher_details'] ??
        []) as List;
    return TeacherDetailsResponse(
      status: json['Status'] ?? json['status'],
      statusCode: json['StatusCode'] ?? json['statusCode'],
      message: json['Message'] ?? json['message'],
      lstTeacherDetails:
      list.map((e) => TeacherDetail.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Status': status,
    'StatusCode': statusCode,
    'Message': message,
    'lstTeacherDetails': lstTeacherDetails.map((e) => e.toJson()).toList(),
  };
}

class TeacherDetail {
  TeacherDetail({
    required this.className,
    required this.section,
    required this.classTeacherName,
    required this.employeeCode,
    required this.employeeStatus,
  });

  final String? className;         // "Class"
  final String? section;           // "Section"
  final String? classTeacherName;  // "ClassTeacherName"
  final String? employeeCode;      // "EmployeeCode"
  final String? employeeStatus;    // "EmployeeStatus"

  factory TeacherDetail.fromJson(Map<String, dynamic> json) => TeacherDetail(
    className: json['Class'] ?? json['class'],
    section: json['Section'] ?? json['section'],
    classTeacherName:
    json['ClassTeacherName'] ?? json['classTeacherName'],
    employeeCode: json['EmployeeCode'] ?? json['employeeCode'],
    employeeStatus: json['EmployeeStatus'] ?? json['employeeStatus'],
  );

  Map<String, dynamic> toJson() => {
    'Class': className,
    'Section': section,
    'ClassTeacherName': classTeacherName,
    'EmployeeCode': employeeCode,
    'EmployeeStatus': employeeStatus,
  };
}