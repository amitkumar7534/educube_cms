// To parse this JSON data, do
//
//     final termsModel = termsModelFromJson(jsonString);

import 'dart:convert';

TermsModel termsModelFromJson(String str) => TermsModel.fromJson(json.decode(str));

String termsModelToJson(TermsModel data) => json.encode(data.toJson());

class TermsModel {
  String? termId;
  String? termValue;

  TermsModel({
    this.termId,
    this.termValue,
  });

  TermsModel copyWith({
    String? termId,
    String? termValue,
  }) =>
      TermsModel(
        termId: termId ?? this.termId,
        termValue: termValue ?? this.termValue,
      );

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    termId: json["Term_Id"],
    termValue: json["Term_Value"],
  );

  Map<String, dynamic> toJson() => {
    "Term_Id": termId,
    "Term_Value": termValue,
  };
}
