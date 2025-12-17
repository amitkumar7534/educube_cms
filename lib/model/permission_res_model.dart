// To parse this JSON data, do
//
//     final permissionResModel = permissionResModelFromJson(jsonString);

import 'dart:convert';

PermissionResModel permissionResModelFromJson(String str) => PermissionResModel.fromJson(json.decode(str));

String permissionResModelToJson(PermissionResModel data) => json.encode(data.toJson());

class PermissionResModel {
  bool? status;
  int? statusCode;
  String? message;
  ObjPermissionOrderDetails? objPermissionOrderDetails;

  PermissionResModel({
    this.status,
    this.statusCode,
    this.message,
    this.objPermissionOrderDetails,
  });

  factory PermissionResModel.fromJson(Map<String, dynamic> json) => PermissionResModel(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    objPermissionOrderDetails: json["objPermissionOrderDetails"] == null ? null : ObjPermissionOrderDetails.fromJson(json["objPermissionOrderDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "objPermissionOrderDetails": objPermissionOrderDetails?.toJson(),
  };
}

class ObjPermissionOrderDetails {
  bool? cashfreeStatus;
  String? redirectUrl;

  ObjPermissionOrderDetails({
    this.cashfreeStatus,
    this.redirectUrl,
  });

  factory ObjPermissionOrderDetails.fromJson(Map<String, dynamic> json) => ObjPermissionOrderDetails(
    cashfreeStatus: json["cashfree_status"],
    redirectUrl: json["redirect_url"],
  );

  Map<String, dynamic> toJson() => {
    "cashfree_status": cashfreeStatus,
    "redirect_url": redirectUrl,
  };
}
