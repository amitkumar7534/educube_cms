// To parse this JSON data, do
//
//     final feeMonthModel = feeMonthModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

FeeMonthModel feeMonthModelFromJson(String str) => FeeMonthModel.fromJson(json.decode(str));

String feeMonthModelToJson(FeeMonthModel data) => json.encode(data.toJson());

class FeeMonthModel  extends Equatable{
  String? feeMonthId;
  String? feeMonthValue;

  FeeMonthModel({
    this.feeMonthId,
    this.feeMonthValue,
  });

  FeeMonthModel copyWith({
    String? feeMonthId,
    String? feeMonthValue,
  }) =>
      FeeMonthModel(
        feeMonthId: feeMonthId ?? this.feeMonthId,
        feeMonthValue: feeMonthValue ?? this.feeMonthValue,
      );

  factory FeeMonthModel.fromJson(Map<String, dynamic> json) => FeeMonthModel(
    feeMonthId: json["FeeMonth_Id"],
    feeMonthValue: json["FeeMonth_Value"],
  );

  DateTime? get dateTime {
    if(feeMonthId != null && feeMonthId!.trim().isNotEmpty){
      return DateFormat('M_yyyy').parse(feeMonthId!);
    }
    return null;
  }


  String dateTimeToDateFormat(DateTime date, String toFormat){
    return DateFormat(toFormat).format(date);
  }

  Map<String, dynamic> toJson() => {
    "FeeMonth_Id": feeMonthId,
    "FeeMonth_Value": feeMonthValue,
  };

  @override
  List<Object?> get props => [ feeMonthId, feeMonthValue];
}
