// To parse this JSON data, do
//
//     final notificationResModel = notificationResModelFromJson(jsonString);

import 'dart:convert';

UserNotificationResModel notificationResModelFromJson(String str) => UserNotificationResModel.fromJson(json.decode(str));

String notificationResModelToJson(UserNotificationResModel data) => json.encode(data.toJson());

class UserNotificationResModel {
  final NotificationResponse? notificationResponse;

  UserNotificationResModel({
    this.notificationResponse,
  });

  factory UserNotificationResModel.fromJson(Map<String, dynamic> json) => UserNotificationResModel(
    notificationResponse: json["NotificationResponse"] == null ? null : NotificationResponse.fromJson(json["NotificationResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "NotificationResponse": notificationResponse?.toJson(),
  };
}

class NotificationResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<NotificationDetail>? notificationDetails;

  NotificationResponse({
    this.status,
    this.statusCode,
    this.message,
    this.notificationDetails,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    notificationDetails: json["notificationDetails"] == null ? [] : List<NotificationDetail>.from(json["notificationDetails"]!.map((x) => NotificationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "notificationDetails": notificationDetails == null ? [] : List<dynamic>.from(notificationDetails!.map((x) => x.toJson())),
  };
}

class NotificationDetail {
  final int? id;
  final String? messageSubject;
  final String? messageBody;
  final String? messageFromUserId;
  final String? fromUserName;
  final String? startDate;
  final String? endDate;
  final String? addedDate;
  final String? addedDateDateTime1;
  final String? addedDateDateTime;
  final String? toUserId;
  final String? toUserName;
  final String? toEmailId;
  final String? toMobile;
  final String? userGroupId;
  final String? isRead;
  final String? notificationUserId;

  NotificationDetail({
    this.id,
    this.messageSubject,
    this.messageBody,
    this.messageFromUserId,
    this.fromUserName,
    this.startDate,
    this.endDate,
    this.addedDate,
    this.addedDateDateTime1,
    this.addedDateDateTime,
    this.toUserId,
    this.toUserName,
    this.toEmailId,
    this.toMobile,
    this.userGroupId,
    this.isRead,
    this.notificationUserId,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) => NotificationDetail(
    id: json["id"],
    messageSubject: json["message_subject"],
    messageBody: json["message_body"],
    messageFromUserId: json["message_from_user_id"],
    fromUserName: json["from_user_name"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    addedDate: json["added_date"],
    addedDateDateTime1: json["added_date_date_time1"],
    addedDateDateTime: json["added_date_date_time"],
    toUserId: json["to_user_id"],
    toUserName: json["to_user_name"],
    toEmailId: json["to_email_id"],
    toMobile: json["to_mobile"],
    userGroupId: json["user_group_id"],
    isRead: json["is_read"],
    notificationUserId: json["notification_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message_subject": messageSubject,
    "message_body": messageBody,
    "message_from_user_id": messageFromUserId,
    "from_user_name": fromUserName,
    "start_date": startDate,
    "end_date": endDate,
    "added_date": addedDate,
    "added_date_date_time1": addedDateDateTime1,
    "added_date_date_time": addedDateDateTime,
    "to_user_id": toUserId,
    "to_user_name": toUserName,
    "to_email_id": toEmailId,
    "to_mobile": toMobile,
    "user_group_id": userGroupId,
    "is_read": isRead,
    "notification_user_id": notificationUserId,
  };
}
