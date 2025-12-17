// To parse this JSON data, do
//
//     final loginResModel = loginResModelFromJson(jsonString);

import 'dart:convert';

import 'package:educube1/model/user_details.dart';

LoginResModel loginResModelFromJson(String str) =>
    LoginResModel.fromJson(json.decode(str));

String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());

class LoginResModel {
  final LoginResponse? loginResponse;

  LoginResModel({
    this.loginResponse,
  });

  factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
        loginResponse: json["LoginResponse"] == null
            ? null
            : LoginResponse.fromJson(json["LoginResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "LoginResponse": loginResponse?.toJson(),
      };
}

class LoginResponse {
  final bool status;
  final int? statusCode;
  final String message;
  final UserDetails? userDetails;
  final TokenDetails? tokenDetails;

  LoginResponse({
    required this.status,
    this.statusCode,
    required this.message,
    this.userDetails,
    this.tokenDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["Status"],
        statusCode: json["StatusCode"],
        message: json["Message"],
        userDetails: json["userDetails"] == null
            ? null
            : UserDetails.fromJson(json["userDetails"]),
        tokenDetails: json["jwtTokenDetails"] == null
            ? null
            : TokenDetails.fromJson(json["jwtTokenDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "StatusCode": statusCode,
        "Message": message,
        "userDetails": userDetails?.toJson(),
        "jwtTokenDetails": tokenDetails?.toJson(),
      };
}

class TokenDetails {
  final String? token;

  TokenDetails({
    this.token,
  });

  factory TokenDetails.fromJson(Map<String, dynamic> json) => TokenDetails(
        token: json["jwtAccessToken"],
      );

  Map<String, dynamic> toJson() => {
        "jwtAccessToken": token,
      };
}
