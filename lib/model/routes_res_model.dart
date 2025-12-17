// To parse this JSON data, do
//
//     final routesResModel = routesResModelFromJson(jsonString);

import 'dart:convert';

RoutesResModel routesResModelFromJson(String str) => RoutesResModel.fromJson(json.decode(str));

String routesResModelToJson(RoutesResModel data) => json.encode(data.toJson());

class RoutesResModel {
  final RouteResponse? routeResponse;

  RoutesResModel({
    this.routeResponse,
  });

  factory RoutesResModel.fromJson(Map<String, dynamic> json) => RoutesResModel(
    routeResponse: json["RouteResponse"] == null ? null : RouteResponse.fromJson(json["RouteResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "RouteResponse": routeResponse?.toJson(),
  };
}

class RouteResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final Objuser? objuser;
  final Objschool? objschool;

  RouteResponse({
    this.status,
    this.statusCode,
    this.message,
    this.objuser,
    this.objschool,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) => RouteResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    objuser: json["objuser"] == null ? null : Objuser.fromJson(json["objuser"]),
    objschool: json["objschool"] == null ? null : Objschool.fromJson(json["objschool"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "objuser": objuser?.toJson(),
    "objschool": objschool?.toJson(),
  };
}

class Objschool {
  final String? schoolName;
  final String? genLatitude;
  final String? genLongitude;

  Objschool({
    this.schoolName,
    this.genLatitude,
    this.genLongitude,
  });

  factory Objschool.fromJson(Map<String, dynamic> json) => Objschool(
    schoolName: json["school_name"],
    genLatitude: json["gen_latitude"],
    genLongitude: json["gen_longitude"],
  );

  Map<String, dynamic> toJson() => {
    "school_name": schoolName,
    "gen_latitude": genLatitude,
    "gen_longitude": genLongitude,
  };
}

class Objuser {
  final String? name;
  final String? genLatitude;
  final String? genLongitude;

  Objuser({
    this.name,
    this.genLatitude,
    this.genLongitude,
  });

  factory Objuser.fromJson(Map<String, dynamic> json) => Objuser(
    name: json["name"],
    genLatitude: json["gen_latitude"],
    genLongitude: json["gen_longitude"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gen_latitude": genLatitude,
    "gen_longitude": genLongitude,
  };
}
