// To parse this JSON data, do
//
//     final holidayEventResModel = holidayEventResModelFromJson(jsonString);

import 'dart:convert';

HolidayEventResModel holidayEventResModelFromJson(String str) => HolidayEventResModel.fromJson(json.decode(str));

String holidayEventResModelToJson(HolidayEventResModel data) => json.encode(data.toJson());

class HolidayEventResModel {
  final HolidayEventResponse? holidayEventResponse;

  HolidayEventResModel({
    this.holidayEventResponse,
  });

  factory HolidayEventResModel.fromJson(Map<String, dynamic> json) => HolidayEventResModel(
    holidayEventResponse: json["HolidayEventResponse"] == null ? null : HolidayEventResponse.fromJson(json["HolidayEventResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "HolidayEventResponse": holidayEventResponse?.toJson(),
  };
}

class HolidayEventResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<HolidayEventDetail>? lstHolidayEvent;

  HolidayEventResponse({
    this.status,
    this.statusCode,
    this.message,
    this.lstHolidayEvent,
  });

  factory HolidayEventResponse.fromJson(Map<String, dynamic> json) => HolidayEventResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    lstHolidayEvent: json["lstHolidayEvent"] == null ? [] : List<HolidayEventDetail>.from(json["lstHolidayEvent"]!.map((x) => HolidayEventDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "lstHolidayEvent": lstHolidayEvent == null ? [] : List<dynamic>.from(lstHolidayEvent!.map((x) => x.toJson())),
  };
}

class HolidayEventDetail {
  final String? reason;
  final String? role;
  final String? startdate;
  final String? enddate;
  final String? type;

  HolidayEventDetail({
    this.reason,
    this.role,
    this.startdate,
    this.enddate,
    this.type,
  });

  factory HolidayEventDetail.fromJson(Map<String, dynamic> json) => HolidayEventDetail(
    reason: json["reason"],
    role: json["role"],
    startdate: json["startdate"],
    enddate: json["enddate"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "role": role,
    "startdate": startdate,
    "enddate": enddate,
    "type": type,
  };

  // Helper methods for easier usage
  bool get isHoliday => type?.toLowerCase() == 'holiday';
  bool get isEvent => type?.toLowerCase() == 'events';

  // Parse date strings to DateTime objects
  DateTime? get startDateTime => _parseDate(startdate);
  DateTime? get endDateTime => _parseDate(enddate);

  // Helper method to parse date format "06-Apr-2025"
  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;

    try {
      final parts = dateStr.split('-');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final year = int.parse(parts[2]);
        final monthStr = parts[1].toLowerCase();

        final monthMap = {
          'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4,
          'may': 5, 'jun': 6, 'jul': 7, 'aug': 8,
          'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12
        };

        final month = monthMap[monthStr];
        if (month != null) {
          return DateTime(year, month, day);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Check if this event/holiday is active on a given date
  bool isActiveOnDate(DateTime date) {
    final start = startDateTime;
    final end = endDateTime;

    if (start == null || end == null) return false;

    final dateOnly = DateTime(date.year, date.month, date.day);
    final startOnly = DateTime(start.year, start.month, start.day);
    final endOnly = DateTime(end.year, end.month, end.day);

    return dateOnly.isAfter(startOnly.subtract(const Duration(days: 1))) &&
        dateOnly.isBefore(endOnly.add(const Duration(days: 1)));
  }

  // Check if this is a single day event
  bool get isSingleDay => startdate == enddate;

  // Get duration in days
  int get durationInDays {
    final start = startDateTime;
    final end = endDateTime;

    if (start == null || end == null) return 0;

    return end.difference(start).inDays + 1;
  }
}