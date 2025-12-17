import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:educube1/model/TermsModel.dart';
import 'package:educube1/model/class_teacher_response.dart';
import 'package:educube1/model/feeCollectionModel.dart';
import 'package:educube1/model/feeMonthModel.dart';
import 'package:educube1/model/holiday_event_model.dart';
import 'package:educube1/model/login_mobile_response.dart';
import 'package:educube1/model/reset_password_res_model.dart';
import 'package:educube1/model/sibling_res_model.dart';
import 'package:educube1/model/teacher_response.dart';
import 'package:educube1/model/timetable_res_model.dart';
import 'package:educube1/network/remote_services.dart';
import 'package:educube1/services/firebase/fcmNotification.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../model/attendance_res_model.dart';
import '../model/device_res_model.dart';
import '../model/footer_res_model.dart';
import '../model/forgot_password_res_model.dart';
import '../model/login_res_model.dart';
import '../model/month_res_model.dart';
import '../model/notification_res_model.dart';
import '../model/pastTransactionModel.dart';
import '../model/permission_res_model.dart';
import '../model/profile_res_model.dart';
import '../model/routes_res_model.dart';
import '../model/session_details_res_model.dart';
import '../model/standard_res_model.dart';
import '../utils/helpers.dart';
import '../utils/prefrence_manager.dart';
import 'ApiUrls.dart';

class PostRequests {
  PostRequests._();

  static Future<LoginResModel?> loginUser(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.userLogin);

      if (apiResponse != null) {
        return loginResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<LoginResModel?> loginUserUsingSSO(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse = await RemoteService.simplePost(
          requestBody, ApiUrls.userLoginUsingSSO);

      if (apiResponse != null) {
        return loginResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<LoginResModel?> verifyOtp(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.verifyOtp);

      if (apiResponse != null) {
        return loginResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<LoginMobileRes?> loginUsingMobile(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse = await RemoteService.simplePost(
          requestBody, ApiUrls.userLoginUsingMobile);

      if (apiResponse != null) {
        return loginMobileResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<SiblingResModel?> getSiblingDetails(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse = await RemoteService.simplePost(
          requestBody, ApiUrls.getSiblingDetails);

      if (apiResponse != null) {
        return siblingResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<TeacherDetailsResModel?> getTeachers(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getTeacher);

      if (apiResponse != null) {
        return teacherDetailsResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ClassTeachersResModel?> getClassTeacher(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getClassTeacher);

      if (apiResponse != null) {
        return classTeachersResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      print(androidDeviceInfo);
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  static Future<void> saveFcmToken(id) async {
    String? deviceId = await getDeviceId();
    final map = {
      "user_id": id,
      "device_id": deviceId,
      "token_id": FCMNotificationService.fcmToken,
      "os_type": Platform.operatingSystem
    };

    Logger().d(map);
    var apiResponse = await RemoteService.simplePost(map, ApiUrls.saveFcmToken,
        showStatus: true);
    Logger().d(apiResponse?.response);
    return;
  }

  static Future<ForgotResModel?> forgotPassword(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.forgotPassword);

      if (apiResponse != null) {
        return forgotResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ProfileResModel?> userProfile(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      final token = await PreferenceManager.userToken;

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      var apiResponse = await RemoteService.simplePost(
        requestBody,
        ApiUrls.userProfile,
        headers: headers,
      );

      if (apiResponse != null) {
        return profileResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ResetPasswordResModel?> resetPassword(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getResetPassword);

      if (apiResponse != null) {
        return resetPasswordResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<UserNotificationResModel?> userNotification(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.userNotification);

      if (apiResponse != null) {
        return notificationResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<NotificationToggleResModel?> notificationToggle(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse = await RemoteService.simplePost(
          requestBody, ApiUrls.notificationToggle,
          showStatus: true);

      if (apiResponse != null) {
        return deviceResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<MonthResModel?> userMonth(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getMonth);

      if (apiResponse != null) {
        return monthResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<StandardResModel?> userStandard(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.userStandard);

      if (apiResponse != null) {
        return standardResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<SessionDetailsResModel?> getSessionDetails(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse = await RemoteService.simplePost(
          requestBody, ApiUrls.getSessionDetails);

      if (apiResponse != null) {
        return sessionDetailsResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<AttendanceResModel?> getAttendance(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      Logger().d('has internet....');

      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getAttendance);

      if (apiResponse != null) {
        return attendanceResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      Logger().d('no internet....');

      return null;
    }
  }

  static Future<TimeTableResponseModel?> getTimeTable(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      Logger().d('has internet....');

      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getTimeTable);

      if (apiResponse != null) {
        return timeTableResponseModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      Logger().d('no internet....');

      return null;
    }
  }

  static Future<HolidayEventResModel?> getEvents(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      Logger().d('has internet....');

      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getEvents);

      if (apiResponse != null) {
        return holidayEventResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      Logger().d('no internet....');

      return null;
    }
  }

  static Future<List<PastTransactionModel>?> getPastTransactions(
      Map<String, dynamic> data) async {
    try {
      if (await Helpers.checkConnectivity()) {
        var apiResponse =
            await RemoteService.simplePost(data, ApiUrls.getPastTransaction);
        if (apiResponse != null) {
          final body =
              jsonDecode(apiResponse.response!) as Map<String, dynamic>;
          if (body['PastTransRes']['Status']) {
            final list =
                body['PastTransRes']['lstPastTransactionReceiptDetails'] ?? [];
            return List<PastTransactionModel>.from(
                list.map((json) => PastTransactionModel.fromJson(json)));
          } else {
            throw body['PastTransRes']['Message'];
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<FeeMonthModel>?> getFeeMonths(
      Map<String, dynamic> data) async {
    try {
      if (await Helpers.checkConnectivity()) {
        var apiResponse =
            await RemoteService.simplePost(data, ApiUrls.getFeeMonth);
        if (apiResponse != null) {
          final body =
              jsonDecode(apiResponse.response!) as Map<String, dynamic>;
          if (body['FeeMonthResponse']['Status']) {
            final list = body['FeeMonthResponse']['lstFeeMonthDetail'] ?? [];
            return List<FeeMonthModel>.from(
                list.map((json) => FeeMonthModel.fromJson(json)));
          } else {
            throw body['FeeMonthResponse']['Message'];
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getPaymentSession(
      String? schoolId) async {
    try {
      final data = {"school_id": schoolId};
      if (await Helpers.checkConnectivity()) {
        var apiResponse =
            await RemoteService.simplePost(data, ApiUrls.getPaymentSession);
        if (apiResponse != null) {
          final body =
              jsonDecode(apiResponse.response!) as Map<String, dynamic>;
          // Logger().d(apiResponse.response);
          if (body['CashFreeCredentailsResponse']['Status']) {
            return body['CashFreeCredentailsResponse']
                ['objCashFreeCredentails'];
          } else {
            throw body['CashFreeCredentailsResponse']['Message'];
          }

          // {
          //   "CashFreeCredentailsResponse":{
          //     "Status":true,
          //     "StatusCode":200,
          //     "Message":"Get CashFree Credentails Details",
          //     "objCashFreeCredentails":{
          //            "school_id":"84",
          //            "client_id":"5566694e7a657c8c61575ea82c966655",
          //            "secret_key":"e64ae5466845a81111cd5234afcbb5290e651d79"
          //     }
          //  }
          // }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static String _strToDateFormat(
      String date, String fromFormat, String toFormat) {
    if (date.trim().isNotEmpty) {
      DateTime parseDate = DateFormat(fromFormat).parse(date);
      return DateFormat(toFormat).format(parseDate);
    } else {
      return '';
    }
  }

  static Future<List<FeeCollectionModel>?> getFeeCollection(
      Map<String, dynamic> data) async {
    try {
      if (await Helpers.checkConnectivity()) {
        var apiResponse =
            await RemoteService.simplePost(data, ApiUrls.getFeeCollection);
        if (apiResponse != null) {
          final body =
              jsonDecode(apiResponse.response!) as Map<String, dynamic>;
          Logger().d(body);
          if (body['FeeCollectionResponse']['Status']) {
            final List list = body['FeeCollectionResponse']
                    ['lstArrear_FeeCollectionDetails'] ??
                [];
            final List list1 = body['FeeCollectionResponse']
                    ['lstCurrent_Year_FeeCollectionDetails'] ??
                [];
            list.addAll(list1);

            List miscellaneous_Detail =
                body['FeeCollectionResponse']['lstMiscellaneous_Detail'];

            if (miscellaneous_Detail != null) {
              List misObjList = List<Map<String, dynamic>>.from(
                  miscellaneous_Detail.map((e) => {
                        "fee_structure_name": e['fee_item'],
                        "fee_end_date": _strToDateFormat(
                            e['collection_month'], 'dd/MM/yyyy', 'dd-MM-yyyy'),
                        "payment_amount": e['miscellaneous_due_amount'],
                      }));
              list.addAll(misObjList);
            }

            List<FeeCollectionModel> result = List<FeeCollectionModel>.from(
                list.map((json) => FeeCollectionModel.fromJson(json)));

            return result;
          } else {
            throw body['FeeCollectionResponse']['Message'];
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> getPastTransactionReceipt(
      Map<String, dynamic> data) async {
    try {
      if (await Helpers.checkConnectivity()) {
        var apiResponse = await RemoteService.simplePost(
            data, ApiUrls.getPastTransactionReceipt);
        if (apiResponse != null) {
          final body =
              jsonDecode(apiResponse.response!) as Map<String, dynamic>;
          if (body['PastTransReceiptRes']['Status']) {
            final html = body['PastTransReceiptRes']['Text'] ?? '';
            return html;
          } else {
            throw body['PastTransReceiptRes']['Message'];
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future updatePaymentResponse(Map<String, dynamic> data) async {
    try {
      if (await Helpers.checkConnectivity()) {
        var apiResponse =
            await RemoteService.simplePost(data, ApiUrls.updatePaymentResponse);
        if (apiResponse != null) {
          final body =
              jsonDecode(apiResponse.response!) as Map<String, dynamic>;

          final data = body['UpdateCashFreeOrderDetailsResponse'];

          //     UpdateCashFreeOrderDetailsResponse {
          //       Status (boolean, optional),
          // StatusCode (integer, optional),
          // Message (string, optional),
          // objUpdateCashFreeOrderDetails (UpdateCashFreeOrderDetails, optional)
          // }
          // UpdateCashFreeOrderDetails {
          // status (string, optional)
          // }

          if (data['Status']) {
            return;
          } else {
            throw data['Message'];
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> prePayment(
      Map<String, dynamic> data) async {
    try {
      // Logger().d(data);
      if (await Helpers.checkConnectivity()) {
        var apiResponse =
            await RemoteService.simplePost(data, ApiUrls.prePayment);
        if (apiResponse != null) {
          // Logger().d(apiResponse.response);
          final body =
              jsonDecode(apiResponse.response!) as Map<String, dynamic>;
          final data = body['CashFreeOrderDetailsResponse'];
          if (data['Status']) {
            return data['objCashFreeOrderDetails'];
          } else {
            throw data['Message'];
          }
          //       {"CashFreeOrderDetailsResponse":
          // {"Status":true,"StatusCode":200,
          //   "Message":"Create order cashfree successfully",
          //   "objCashFreeOrderDetails":{"order_id":"3_15_991866_171582_20240524174313","order_amount":"1.0","order_currency":"INR","order_note":"school_name:Aliganj  II__student_id:171582student_name:algii_63_27pp","customer_id":"171582","customer_name":"algii_63_27pp","customer_email":null,"customer_phone":"9999999999","return_url":"","voucher_id":"991866","erp_gen_txn_unique_id":"3_15_171582_20240524174313_CF"}}}
          //
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<RoutesResModel?> getRoutes(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getRoutes);

      if (apiResponse != null) {
        return routesResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<FooterResModel?> footerContent(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.footerContent);
      if (apiResponse != null) {
        return footerResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<TermsModel>?> getPerformanceTerms(
      Map<String, dynamic> requestBody) async {
    try {
      var body = json.encode(requestBody);
      if (await Helpers.checkConnectivity()) {
        final apiResponse = await http.post(
            Uri.parse(ApiUrls.baseUrl + ApiUrls.getTerms),
            headers: RemoteService.getHeaders(),
            body: body);

        var responseCode = apiResponse.statusCode;
        if (responseCode == 200) {
          final data = jsonDecode(apiResponse.body) as Map<String, dynamic>;
          if (data['TermResponse']['Status']) {
            final list = data['TermResponse']['lstTermDetail'];
            return List<TermsModel>.from(
                list.map((json) => TermsModel.fromJson(json)));
          } else {
            if (data['TermResponse']['lstTermDetail'] == null) {
              return [];
            } else {
              throw data['TermResponse']['Message'];
            }
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      // Logger().d('exception ::'+e.toString());
      rethrow;
    }
  }

  static Future<String?> getPerformance(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getPerformance);

      if (apiResponse != null) {
        return apiResponse.response!;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<PermissionResModel?> getPermission(
      Map<String, dynamic> requestBody) async {
    if (await Helpers.checkConnectivity()) {
      var apiResponse =
          await RemoteService.simplePost(requestBody, ApiUrls.getPermission);
      if (apiResponse != null) {
        final json = jsonDecode(apiResponse.response!) as Map<String, dynamic>;

// Logger().d(json);
        final data = PermissionResModel.fromJson(json['PermissionResponse']);

        Logger().d(data.toJson());
        return data;
      } else {
        Logger().d('else case fire ....');
        return null;
      }
    } else {
      return null;
    }
  }
}
