// To parse this JSON data, do
//
//     final academicResModel = academicResModelFromJson(jsonString);

import 'dart:convert';

AcademicResModel academicResModelFromJson(String str) => AcademicResModel.fromJson(json.decode(str));

String academicResModelToJson(AcademicResModel data) => json.encode(data.toJson());

class AcademicResModel {
  final AcademicYearResponse? academicYearResponse;

  AcademicResModel({
    this.academicYearResponse,
  });

  factory AcademicResModel.fromJson(Map<String, dynamic> json) => AcademicResModel(
    academicYearResponse: json["AcademicYearResponse"] == null ? null : AcademicYearResponse.fromJson(json["AcademicYearResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "AcademicYearResponse": academicYearResponse?.toJson(),
  };
}

class AcademicYearResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<LstObjAcademicYearDetail>? lstObjAcademicYearDetails;

  AcademicYearResponse({
    this.status,
    this.statusCode,
    this.message,
    this.lstObjAcademicYearDetails,
  });

  factory AcademicYearResponse.fromJson(Map<String, dynamic> json) => AcademicYearResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    lstObjAcademicYearDetails: json["lstObjAcademicYearDetails"] == null ? [] : List<LstObjAcademicYearDetail>.from(json["lstObjAcademicYearDetails"]!.map((x) => LstObjAcademicYearDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "lstObjAcademicYearDetails": lstObjAcademicYearDetails == null ? [] : List<dynamic>.from(lstObjAcademicYearDetails!.map((x) => x.toJson())),
  };
}

class LstObjAcademicYearDetail {
  final String? yearId;
  final String? yearValue;
  final bool? isSelected;

  LstObjAcademicYearDetail({
    this.yearId,
    this.yearValue,
    this.isSelected,
  });

  factory LstObjAcademicYearDetail.fromJson(Map<String, dynamic> json) => LstObjAcademicYearDetail(
    yearId: json["Year_Id"],
    yearValue: json["Year_Value"],
    isSelected: json["Is_Selected"],
  );

  Map<String, dynamic> toJson() => {
    "Year_Id": yearId,
    "Year_Value": yearValue,
    "Is_Selected": isSelected,
  };
}
