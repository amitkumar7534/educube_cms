import 'dart:convert';

SiblingResModel siblingResModelFromJson(String str) =>
    SiblingResModel.fromJson(json.decode(str));

class SiblingResModel {
  SiblingResModel({
    required this.siblingResponse,
  });

  final SiblingResponse? siblingResponse;

  factory SiblingResModel.fromJson(Map<String, dynamic> json) {
    return SiblingResModel(
      siblingResponse: json["SiblingResponse"] == null
          ? null
          : SiblingResponse.fromJson(json["SiblingResponse"]),
    );
  }
}

class SiblingResponse {
  SiblingResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.lstsibling,
  });

  final bool? status;
  final int? statusCode;
  final String? message;
  final List<Lstsibling> lstsibling;

  factory SiblingResponse.fromJson(Map<String, dynamic> json) {
    return SiblingResponse(
      status: json["Status"],
      statusCode: json["StatusCode"],
      message: json["Message"],
      lstsibling: json["lstsibling"] == null
          ? []
          : List<Lstsibling>.from(
          (json["lstsibling"] as List).map((x) => Lstsibling.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Status": status,
      "StatusCode": statusCode,
      "Message": message,
      "lstsibling": lstsibling.map((x) => x.toJson()).toList(),
    };
  }
}

class Lstsibling {
  Lstsibling({
    required this.schoolId,
    required this.academicYear,
    required this.userId,
    required this.fullName,
    required this.userName,
    required this.roleId,
    required this.roleName,
    required this.grNumber,
    required this.institutionId, // NEW
    required this.classId,       // NEW
    required this.className,
    required this.sectionId,     // NEW
    required this.sectionName,
    required this.campusName,
    required this.studentImage,
    required this.fatherImage,   // NEW
    required this.motherImage,   // NEW
  });

  final String? schoolId;
  final dynamic academicYear;
  final String? userId;
  final String? fullName;
  final String? userName;
  final String? roleId;
  final String? roleName;
  final String? grNumber;
  final String? institutionId; // new
  final String? classId;       // new
  final String? className;
  final String? sectionId;     // new
  final String? sectionName;
  final String? campusName;
  final String? studentImage;
  final String? fatherImage;   // new
  final String? motherImage;   // new

  factory Lstsibling.fromJson(Map<String, dynamic> json) {
    return Lstsibling(
      schoolId: json["school_id"],
      academicYear: json["academic_year"],
      userId: json["user_id"],
      fullName: json["full_name"],
      userName: json["user_name"],
      roleId: json["role_id"],
      roleName: json["role_name"],
      grNumber: json["gr_number"],
      institutionId: json["institution_id"],     // new
      classId: json["class_id"],                 // new
      className: json["class_name"],
      sectionId: json["section_id"],             // new
      sectionName: json["section_name"],
      campusName: json["campus_name"],
      studentImage: json["student_image"],
      fatherImage: json["father_image"],         // new
      motherImage: json["mother_image"],         // new
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "school_id": schoolId,
      "academic_year": academicYear,
      "user_id": userId,
      "full_name": fullName,
      "user_name": userName,
      "role_id": roleId,
      "role_name": roleName,
      "gr_number": grNumber,
      "institution_id": institutionId, // new
      "class_id": classId,             // new
      "class_name": className,
      "section_id": sectionId,         // new
      "section_name": sectionName,
      "campus_name": campusName,
      "student_image": studentImage,
      "father_image": fatherImage,     // new
      "mother_image": motherImage,     // new
    };
  }
}
