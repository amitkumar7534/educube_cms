// To parse this JSON data, do
//
//     final forgotResModel = forgotResModelFromJson(jsonString);

import 'dart:convert';

ForgotResModel forgotResModelFromJson(String str) => ForgotResModel.fromJson(json.decode(str));

String forgotResModelToJson(ForgotResModel data) => json.encode(data.toJson());

class ForgotResModel {
  final ForgotPasswordResponse? forgotPasswordResponse;

  ForgotResModel({
    this.forgotPasswordResponse,
  });

  factory ForgotResModel.fromJson(Map<String, dynamic> json) => ForgotResModel(
    forgotPasswordResponse: json["ForgotPasswordResponse"] == null ? null : ForgotPasswordResponse.fromJson(json["ForgotPasswordResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "ForgotPasswordResponse": forgotPasswordResponse?.toJson(),
  };
}

class ForgotPasswordResponse {
  final bool? status;
  final int? statusCode;
  final String message;

  ForgotPasswordResponse({
    this.status,
    this.statusCode,
    required this.message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
  };
}
