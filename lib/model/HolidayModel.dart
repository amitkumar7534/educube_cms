import 'dart:convert';

class HolidayModel {
  int? dateDay;

  HolidayModel({
    this.dateDay,
  });

  factory HolidayModel.fromRawJson(String str) => HolidayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
    dateDay: json["date_day"],
  );

  Map<String, dynamic> toJson() => {
    "date_day": dateDay,
  };
}
