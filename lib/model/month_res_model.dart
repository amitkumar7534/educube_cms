// To parse this JSON data, do
//
//     final monthResModel = monthResModelFromJson(jsonString);

import 'dart:convert';

MonthResModel monthResModelFromJson(String str) => MonthResModel.fromJson(json.decode(str));

String monthResModelToJson(MonthResModel data) => json.encode(data.toJson());

class MonthResModel {
  final MonthResponse? monthResponse;

  MonthResModel({
    this.monthResponse,
  });

  factory MonthResModel.fromJson(Map<String, dynamic> json) => MonthResModel(
    monthResponse: json["MonthResponse"] == null ? null : MonthResponse.fromJson(json["MonthResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "MonthResponse": monthResponse?.toJson(),
  };
}

class MonthResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<LstMonthDetail>? lstMonthDetail;

  MonthResponse({
    this.status,
    this.statusCode,
    this.message,
    this.lstMonthDetail,
  });

  factory MonthResponse.fromJson(Map<String, dynamic> json) => MonthResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    lstMonthDetail: json["lstMonthDetail"] == null ? [] : List<LstMonthDetail>.from(json["lstMonthDetail"]!.map((x) => LstMonthDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "lstMonthDetail": lstMonthDetail == null ? [] : List<dynamic>.from(lstMonthDetail!.map((x) => x.toJson())),
  };
}

class LstMonthDetail {
  final String? monthId;
  final String? monthValue;

  LstMonthDetail({
    this.monthId,
    this.monthValue,
  });

  factory LstMonthDetail.fromJson(Map<String, dynamic> json) => LstMonthDetail(
    monthId: json["Month_Id"],
    monthValue: json["Month_Value"],
  );

  Map<String, dynamic> toJson() => {
    "Month_Id": monthId,
    "Month_Value": monthValue,
  };
}
