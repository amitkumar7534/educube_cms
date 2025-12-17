// To parse this JSON data, do
//
//     final resetPasswordResModel = resetPasswordResModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordResModel resetPasswordResModelFromJson(String str) => ResetPasswordResModel.fromJson(json.decode(str));

String resetPasswordResModelToJson(ResetPasswordResModel data) => json.encode(data.toJson());

class ResetPasswordResModel {
  final ChangePasswordResponse? changePasswordResponse;

  ResetPasswordResModel({
    this.changePasswordResponse,
  });

  factory ResetPasswordResModel.fromJson(Map<String, dynamic> json) => ResetPasswordResModel(
    changePasswordResponse: json["ChangePasswordResponse"] == null ? null : ChangePasswordResponse.fromJson(json["ChangePasswordResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "ChangePasswordResponse": changePasswordResponse?.toJson(),
  };
}

class ChangePasswordResponse {
  final bool? status;
  final int? statusCode;
  final String? message;

  ChangePasswordResponse({
    this.status,
    this.statusCode,
    this.message,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => ChangePasswordResponse(
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
