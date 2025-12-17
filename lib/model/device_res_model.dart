// To parse this JSON data, do
//
//     final deviceResModel = deviceResModelFromJson(jsonString);

import 'dart:convert';

NotificationToggleResModel deviceResModelFromJson(String str) => NotificationToggleResModel.fromJson(json.decode(str));

String deviceResModelToJson(NotificationToggleResModel data) => json.encode(data.toJson());

class NotificationToggleResModel {
  final DeviceResponse? deviceResponse;

  NotificationToggleResModel({
    this.deviceResponse,
  });

  factory NotificationToggleResModel.fromJson(Map<String, dynamic> json) => NotificationToggleResModel(
    deviceResponse: json["DeviceResponse"] == null ? null : DeviceResponse.fromJson(json["DeviceResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "DeviceResponse": deviceResponse?.toJson(),
  };
}

class DeviceResponse {
  final bool? status;
  final int? statusCode;
  final String? message;

  DeviceResponse({
    this.status,
    this.statusCode,
    this.message,
  });

  factory DeviceResponse.fromJson(Map<String, dynamic> json) => DeviceResponse(
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
