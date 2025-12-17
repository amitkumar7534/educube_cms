import 'dart:async';

import 'package:educube1/model/pastTransactionModel.dart';
import 'package:educube1/network/post_requests.dart';
import 'package:educube1/services/payment/paymentServices.dart';
import 'package:educube1/utils/app_alerts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
// import 'package:show_loader_dialog/show_loader_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/feeCollectionModel.dart';
import '../../model/feeMonthModel.dart';
import '../../model/permission_res_model.dart';
import '../../utils/prefrence_manager.dart';
import '../../view/pages/make_payment/cardForm.dart';
import '../../view/pages/webview/webview_screen.dart';

enum PaymentMethod { upi, card, netbanking, web, pay }

// class PaymentCardModel {
//   String cardNo;
//   String xMonth;
//   String xYear;
//   String cvv;
//
//   PaymentCardModel({
//     required this.cardNo,
//     required this.xMonth,
//     required this.xYear,
//     required this.cvv,
//   });
// }

class FeesController extends GetxController {
  WebViewController webViewController = WebViewController();
  var isLoading = false.obs;
  RxString webUrlLink = ''.obs;
   // webViewLink = Rx<ObjPermissionOrderDetails?>(null);
  // final RxString selectedValue = "".obs;
  // final RxString selectedMonth = "".obs;
  final RxList items = [
    '2023-2024',
    '2022-2021',
    '2021-2022',
    '2020-2021',
    '2019-2020',
    '2018-2019',
    '2017-2016',
    '2016-2015',
  ].obs;
  final RxList allMonths = [
    'July-2023',
    'August-2023',
    'September-2023',
    'October-2023',
    'November-2023',
    'December-2023',
    'January-2023',
    'February-2023',
    'March-2023',
    'April-2023',
    'May-2023',
    'June-2023',
    'July-2023',
  ].obs;
  @override
  void onInit() {
    getPermission();
    // TODO: implement onInit
    super.onInit();
  }
  // setSelectedValue(newValue){
  //   selectedValue.value = newValue;
  // }
  // setMonth(newValue){
  //   selectedMonth.value = newValue;
  // }

  //----------------------------------------------------------------------------
  String _academicYear = '';
  String _uid = '';
  String _schoolId = '';
  String _uName = '';
  String _uPassword = '';
  final RxBool _showPayBtn = RxBool(false);

  bool get showPayBtn => _showPayBtn.value;

  final RxInt _activeTab = RxInt(0);

  int get activeTab => _activeTab.value;

  final RxList<PastTransactionModel> _pastTransactions = RxList();

  List<PastTransactionModel> get pastTransactions => _pastTransactions;

  final RxList<FeeMonthModel> _feeMonths = RxList();

  List<FeeMonthModel> get feeMonths => _feeMonths;

  final Rx<FeeMonthModel?> _selectMonth = Rx<FeeMonthModel?>(null);

  FeeMonthModel? get selectMonth => _selectMonth.value;

  final RxList<FeeCollectionModel> _feeCollection = RxList();

  List<FeeCollectionModel> get feeCollection => _feeCollection;

  Future<Map<String, dynamic>> onTabAction(int index) async {
    _activeTab.value = index;
    if (index == 0) {
      return getFeeCollection(selectMonth?.feeMonthId);
    } else {
      return getPastTransactions();
    }
  }


  final RxString _receiptData = RxString('');

  String get receiptData => _receiptData.value;

  Future<Map<String, dynamic>> setSelectedMonth(FeeMonthModel value) async {
    _selectMonth.value = value;
    return getFeeCollection(selectMonth?.feeMonthId);
  }

  void _restData() {}

  Future<Map<String, dynamic>> getData() async {
    try {
      _activeTab.value = 0;
      _selectMonth.value = null;
      _restData();
      getUserData();
      // getPermission();
      await getFeeMonthList();
      return await getFeeCollection(selectMonth?.feeMonthId);
    } catch (e) {
      print('check pay btn ::: exce...$e');
      return {'status': false, 'msg': e.toString()};
    }
  }

  void getUserData() {
  //  _uid = PreferenceManager.user?.uId ?? '';
    _uid = PreferenceManager.getPref("user_id").toString();
    _academicYear = PreferenceManager.user?.currentAcademicYear ?? '';
  //  _schoolId = PreferenceManager.user?.schoolId ?? '';
    _schoolId = PreferenceManager.getPref("school_id").toString();
    _uName = PreferenceManager.user?.username ?? '';
    _uPassword = PreferenceManager.userPassword;

    final selectedYear = _selectMonth.value?.feeMonthId?.split('_')[1] ?? DateTime.now().year.toString();

    // Logger().d('Testing for year -------${selectedYear}');

       final total = feeCollection.fold(0.0, (previousValue, element) {
         var amount = element.paymentAmount ?? '0';
         final result = num.tryParse(amount) ?? 0;
         return result + previousValue;
        },);


    // _showPayBtn.value = _academicYear == selectedYear;
    _showPayBtn.value = total > 0;

    // print('check pay btn ::: $showPayBtn');
    // print('school id ::: $_schoolId');
  }



  Future<Map<String, dynamic>> getPastTransactions() async {
    try {
      final data = {"academic_year": _academicYear, "user_id": _uid};

      List<PastTransactionModel>? list =
          await PostRequests.getPastTransactions(data);
      if (list != null) {
        _pastTransactions.value = list;
        _pastTransactions.refresh();
        return {
          'status': true,
        };
      } else {
        return {
          'status': true,
        };
      }
    } catch (e) {
      return {'status': false, 'msg': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getFeeMonthList() async {
    try {
      final data = {"school_id": _schoolId, "academic_year": _academicYear};

      // Logger().d(data);

    //  {
    //    "school_id": "88",
    //    "academic_year": "2024"
    //  }

      List<FeeMonthModel>? list = await PostRequests.getFeeMonths(data);
      if (list != null) {
        // Logger().d(list);
        // _feeMonths.value = list;
        if (selectMonth == null) {
          final currentDate = DateTime.now();
          final obj = FeeMonthModel(
              feeMonthValue:
                  'Upto ${dateTimeToDateFormat(currentDate, 'MMMM')} ${currentDate.year}',
              feeMonthId: '${currentDate.month}_${currentDate.year}');
          if (!list.contains(obj)) {
            list.add(obj);
          }

          _selectMonth.value = obj;
        }
        list.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
        final allObj = FeeMonthModel(feeMonthValue: 'All', feeMonthId: null);

        list.insert(0, allObj);
        if (list.isNotEmpty) {
          _feeMonths.value = list;
          _feeMonths.refresh();
        }

        return {
          'status': true,
        };
      } else {
        return {
          'status': true,
        };
      }
    } catch (e) {
      return {'status': false, 'msg': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getFeeCollection(String? month) async {
    try {
      if (month != null) {
        final year = month.split('_')[1];
        if (int.parse(year) < DateTime.now().year) {
          month = null;
        }
      }

      //   "user_id": "491543",
      // "academic_year": "2024",
      // "month": "7_2024"
      final data = {
        // "user_id": "491543",
        // "academic_year": '2024',
        // "academic_year": month == null ? null : _academicYear,
        // "month": '7_2024'

        "user_id": _uid,
        "academic_year": _academicYear,
        // "academic_year": month == null ? null : _academicYear,
        "month": month ?? 0
      };

      Logger().d(data);

    //  {
    //    "user_id": "472570",
    //    "academic_year": "2024",
    //    "month": "1_2025"
    //  }

      List<FeeCollectionModel>? list =
          await PostRequests.getFeeCollection(data);
      if (list != null) {
        _feeCollection.value = list;
        getUserData();
        _feeCollection.refresh();
        return {
          'status': true,
        };
      } else {
        return {
          'status': true,
        };
      }
    } catch (e) {
      return {'status': false, 'msg': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getReceipt(String vId) async {
    try {
      final data = {
        "user_id": _uid,
        "academic_year": _academicYear,
        "voucher_id": vId
      };
      Logger().d(data);

      String? html = await PostRequests.getPastTransactionReceipt(data);
      if (html != null) {
        _receiptData.value = html;
        return {
          'status': true,
        };
      } else {
        _receiptData.value = '';
        return {
          'status': true,
        };
      }
    } catch (e) {
      return {'status': false, 'msg': e.toString()};
    }
  }

  String strToDateFormat(String date, String fromFormat, String toFormat) {
    if (date.trim().isNotEmpty) {
      DateTime parseDate = DateFormat(fromFormat).parse(date);
      return DateFormat(toFormat).format(parseDate);
    } else {
      return '';
    }
  }

  String dateTimeToDateFormat(DateTime date, String toFormat) {
    return DateFormat(toFormat).format(date);
  }

  //-------------------------[payment]-----------------------------------------

  Function()? hitPaymentGateWay;
  Function(String url)? openPaymentWebView;
  final PaymentGateWayModel _paymentObj = PaymentGateWayModel();
  getPermission() async {
    Map<String, dynamic> requestBody = {
      "school_id": _schoolId,
      "username": _uName,
      "password": _uPassword
    };
    Logger().d(requestBody);
    try {
      isLoading.value = true;
      var apiResponse = await PostRequests.getPermission(requestBody);

      // Logger().d(apiResponse?.toJson());
       if (apiResponse?.objPermissionOrderDetails?.cashfreeStatus == true) {
         webUrlLink.value  = apiResponse?.objPermissionOrderDetails!.redirectUrl.toString() ?? '';
         print("${webUrlLink.value}URL>>>>>");

         getPaymentSession().then((error) {
           if (error != null) {
             AppAlerts.error(message: error);
           } else {
             final callback = doPayment(
                 method: PaymentMethod.pay);
             callback['success']?.stream.listen((event) {

               callback['success']?.close();
               callback['error']?.close();
               paymentResult('Success');
             });
             callback['error']?.stream.listen((event) {
               AppAlerts.error(
                   message: event.trim().isNotEmpty
                       ? event
                       : 'Transaction failed');
               callback['success']?.close();
               callback['error']?.close();
               paymentResult('Failed');
             });
           }

           // Get.toNamed(AppRoutes.routeMakePaymentScreen);
         });
     // if (false) {
       // print("${apiResponse!.message}message");
       // hitPaymentGateWay?.call();

      }
       else if(apiResponse?.objPermissionOrderDetails?.cashfreeStatus == false){
         webUrlLink.value  = apiResponse?.objPermissionOrderDetails!.redirectUrl.toString() ?? '';
         webViewController.reload();
         print("${webUrlLink.value}URL>>>>>");

         Get.to(WebViewScreen());
         //launchUrl(Uri.parse("${apiResponse?.objPermissionOrderDetails?.redirectUrl}"));
         //   openPaymentWebView?.call('');

        // AppAlerts.error(message: apiResponse!.message.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }
  void paymentResult(String status) async {
    try {
      EasyLoading.show(dismissOnTap: true);
      final error = await onPaymentComplete(status: status);
      if (error != null) {
        AppAlerts.error(message: error);
      } else {
        AppAlerts.success(message: 'Payment successful');
      }
    } finally {
      EasyLoading.show(dismissOnTap: false);
    }
  }
  Future<String?> getPaymentSession() async {
    try {
      final preResultError = await _prePayment();
      if (preResultError != null) return preResultError;

      final result = await PostRequests.getPaymentSession(_schoolId);
      if (result != null) {
        final list = await PaymentServices.createOrder(
            secretKey: result['secret_key'],
            clientId: result['client_id'],
            amount: _paymentObj.amount!,
            currency: 'INR',
            customerData: _paymentObj.customerData!);
        _paymentObj.paymentOrderId = list[0];
        _paymentObj.paymentSessionId = list[1];
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> _prePayment() async {
    try {
      var feeId = feeCollection[0].feeIds ?? '';
      double paymentAmount = 0;
      double fine = 0;
      double fineConcession = 0;

      for (var item in feeCollection) {
        paymentAmount += double.parse(item.paymentAmount ?? '0.0');
        fine += double.parse(item.fine ?? '0.0');
        fineConcession += double.parse(item.fineConcession ?? '0.0');
      }
      double total = paymentAmount + fine - fineConcession;

      _paymentObj.amount = total;
      final data = {
        "school_id": _schoolId,
        "academic_year": _academicYear,
        "user_id": _uid,
        "fee_id": '$feeId',
        "payment": '$paymentAmount',
        "fine": '$fine',
        "fine_concession": '$fineConcession',
        "total_amount": '$total',
        "misc_item": ""
      };

      final result = await PostRequests.prePayment(data);
      if (result != null) {
        _paymentObj.customerData = {
          "customer_id": result['customer_id'],
          "customer_name": result['customer_name'],
          "customer_email": result[''],
          "customer_phone": result['customer_phone']
        };

        _paymentObj.voucherId = result['voucher_id'];
        return null;
      } else {
        return 'Some thing went wrong';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> onPaymentComplete({required String status}) async {
    try {
      final data = {
        "school_id": _schoolId,
        "payment_id": _paymentObj.paymentOrderId,
        "voucher_id": _paymentObj.voucherId,
        "user_id": _uid,
        "payment_status": status
      };

      final result = await PostRequests.updatePaymentResponse(data);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Map<String, StreamController<String>> doPayment(
      {required PaymentMethod method,
      String? upiId,
      String? upiType,
      PaymentCardModel? cardData}) {
    final service = PaymentServices(
        _paymentObj.paymentOrderId!, _paymentObj.paymentSessionId!);

    service.createSession(
        orderId: service.orderId, paymentSessionId: service.paymentSessionId);

    switch (method) {
      case PaymentMethod.upi:
        if (upiId != null) {
          service.upiCollectPay(upiId: upiId ?? '');
        } else {
          service.upiIntentPay(upiId: upiType ?? '');
        }
        break;
      case PaymentMethod.card:
        service.cardPay(
          cardNo: cardData?.cardNo ?? '',
          cvv: cardData?.cvv ?? '',
          xMonth: cardData?.xMonth ?? '',
          xYear: cardData?.xYear ?? '',
        );
        break;
      case PaymentMethod.netbanking:
        service.netbankingPay();

      case PaymentMethod.pay:
        service.webCheckout();
        // service.pay();
        break;
      case PaymentMethod.web:
        service.pay();
        break;
      // TODO: Handle this case.
    }

    return {
      'success': service.onVerifyListener,
      'error': service.onErrorListener
    };
  }
}

class PaymentGateWayModel {
  String? paymentOrderId;
  String? paymentSessionId;
  double? amount;
  Map<String, dynamic>? customerData;
  String? voucherId;
}









