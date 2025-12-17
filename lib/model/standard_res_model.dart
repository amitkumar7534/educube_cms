// To parse this JSON data, do
//
//     final standardResModel = standardResModelFromJson(jsonString);

import 'dart:convert';

StandardResModel standardResModelFromJson(String str) => StandardResModel.fromJson(json.decode(str));

String standardResModelToJson(StandardResModel data) => json.encode(data.toJson());

class StandardResModel {
  final StandardResponse? standardResponse;

  StandardResModel({
    this.standardResponse,
  });

  factory StandardResModel.fromJson(Map<String, dynamic> json) => StandardResModel(
    standardResponse: json["StandardResponse"] == null ? null : StandardResponse.fromJson(json["StandardResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "StandardResponse": standardResponse?.toJson(),
  };
}

class StandardResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<LstStandardDetail>? lstStandardDetail;

  StandardResponse({
    this.status,
    this.statusCode,
    this.message,
    this.lstStandardDetail,
  });

  factory StandardResponse.fromJson(Map<String, dynamic> json) => StandardResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    lstStandardDetail: json["lstStandardDetail"] == null ? [] : List<LstStandardDetail>.from(json["lstStandardDetail"]!.map((x) => LstStandardDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "lstStandardDetail": lstStandardDetail == null ? [] : List<dynamic>.from(lstStandardDetail!.map((x) => x.toJson())),
  };
}

class LstStandardDetail {
  final String? standardId;
  final String? standardValue;

  LstStandardDetail({
    this.standardId,
    this.standardValue,
  });

  factory LstStandardDetail.fromJson(Map<String, dynamic> json) => LstStandardDetail(
    standardId: json["Standard_Id"],
    standardValue: json["Standard_Value"],
  );

  Map<String, dynamic> toJson() => {
    "Standard_Id": standardId,
    "Standard_Value": standardValue,
  };
}
