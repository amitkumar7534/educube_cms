import 'dart:convert';

class UserDetailModel {
  String? userId;
  String? name;
  String? addmissionDate;
  String? dateOfJoining;
  String? dateOfRetirement;

  UserDetailModel({
    this.userId,
    this.name,
    this.addmissionDate,
    this.dateOfJoining,
    this.dateOfRetirement,
  });

  factory UserDetailModel.fromRawJson(String str) => UserDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetailModel.fromJson(Map<String, dynamic> json) => UserDetailModel(
    userId: json["user_id"],
    name: json["name"],
    addmissionDate: json["addmission_date"],
    dateOfJoining: json["date_of_joining"],
    dateOfRetirement: json["date_of_retirement"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "addmission_date": addmissionDate,
    "date_of_joining": dateOfJoining,
    "date_of_retirement": dateOfRetirement,
  };
}