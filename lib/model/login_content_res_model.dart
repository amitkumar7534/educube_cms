// To parse this JSON data, do
//
//     final loginContentResModel = loginContentResModelFromJson(jsonString);

import 'dart:convert';

LoginContentResModel loginContentResModelFromJson(String str) => LoginContentResModel.fromJson(json.decode(str));

String loginContentResModelToJson(LoginContentResModel data) => json.encode(data.toJson());

class LoginContentResModel {
  LoginContentResponse? loginContentResponse;

  LoginContentResModel({
    this.loginContentResponse,
  });

  factory LoginContentResModel.fromJson(Map<String, dynamic> json) => LoginContentResModel(
    loginContentResponse: json["Login_ContentResponse"] == null ? null : LoginContentResponse.fromJson(json["Login_ContentResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "Login_ContentResponse": loginContentResponse?.toJson(),
  };
}

class LoginContentResponse {
  bool? status;
  int? statusCode;
  String? message;
  LoginContentDetail? loginContentDetail;

  LoginContentResponse({
    this.status,
    this.statusCode,
    this.message,
    this.loginContentDetail,
  });

  factory LoginContentResponse.fromJson(Map<String, dynamic> json) => LoginContentResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    loginContentDetail: json["login_contentDetail"] == null ? null : LoginContentDetail.fromJson(json["login_contentDetail"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "login_contentDetail": loginContentDetail?.toJson(),
  };
}

class LoginContentDetail {
  String? loginContent1;
  String? loginContent2;

  LoginContentDetail({
    this.loginContent1,
    this.loginContent2,
  });

  factory LoginContentDetail.fromJson(Map<String, dynamic> json) => LoginContentDetail(
    loginContent1: json["Login_Content_1"],
    loginContent2: json["Login_Content_2"],
  );

  Map<String, dynamic> toJson() => {
    "Login_Content_1": loginContent1,
    "Login_Content_2": loginContent2,
  };
}
