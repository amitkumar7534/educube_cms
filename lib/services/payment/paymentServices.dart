import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardwidget.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfcard.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfcardpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfnetbanking.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfnetbankingpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfupi.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfupipayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:http/http.dart' as http;

class PaymentServices {
 PaymentServices(this.orderId, this.paymentSessionId);

  String orderId = '';
  String paymentSessionId = "";

  // CFEnvironment environment = CFEnvironment.SANDBOX;
  static CFEnvironment environment = CFEnvironment.PRODUCTION;
  static CFSession? session;
  var cfPaymentGatewayService = CFPaymentGatewayService();

  CFSession? createSession(
      {required String orderId, required String paymentSessionId}) {
    try {
      // orderId = '3_15_991863_491543_20240524161232';
      // paymentSessionId = '3_15_491543_20240524161232_CF';
      session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      // newPay();
      return session;
    } on CFException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  upiCollectPay({required String upiId}) async {
    // testsuccess@gocash or testfailure@gocash or testtpvsuccess@gocash or testtpvfail@gocash or success@upi

    try {
      var upi = CFUPIBuilder()
          .setChannel(CFUPIChannel.COLLECT)
          .setUPIID(environment == CFEnvironment.SANDBOX
              ? 'testsuccess@gocash'
              : upiId)
          .build();
      var upiPayment =
          CFUPIPaymentBuilder().setSession(session!).setUPI(upi).build();
      cfPaymentGatewayService.doPayment(upiPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }

  upiIntentPay({required String upiId}) async {
    // ["tez://", "phonepe://", "paytmmp://", "bhim://"]
    try {
      cfPaymentGatewayService.setCallback(_verifyPayment, _onError);
      var upi = CFUPIBuilder().setChannel(CFUPIChannel.INTENT).setUPIID(
          // upiId
          'tez://').build();
      var upiPayment =
          CFUPIPaymentBuilder().setSession(session!).setUPI(upi).build();
      cfPaymentGatewayService.doPayment(upiPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }

  netbankingPay() async {
    try {
      var netbanking =
          CFNetbankingBuilder().setChannel("link").setBankCode(3003).build();
      var netbankingPayment = CFNetbankingPaymentBuilder()
          .setSession(session!)
          .setNetbanking(netbanking)
          .build();
      cfPaymentGatewayService.doPayment(netbankingPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }

  emi() {}

  cardPay({
    required String cardNo,
    required String xMonth,
    required String xYear,
    required String cvv,
  }) async {
    try {
      cfPaymentGatewayService.setCallback(_verifyPayment, _onError);

      final widget = CFCardWidget(
          inputDecoration: InputDecoration(),
          textStyle: TextStyle(),
          cardListener: (value) {},
          cfSession: session);

      var card = CFCardBuilder()
          // .getCardNumber()
          .setInstrumentId("db178aff-b8cf-420e-b0ba-7af89f0d2263")
          .setCardCVV(cvv)
          .setCardExpiryYear(xYear)
          .setCardExpiryMonth(xMonth)
          .build();
      var cardPayment = CFCardPaymentBuilder()
          .setSession(session!)
          .setCard(card)
          .savePaymentMethod(true)
          .build();
      cfPaymentGatewayService.doPayment(cardPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }

  pay() async {
    try {
      cfPaymentGatewayService.setCallback(_verifyPayment, _onError);
      List<CFPaymentModes> components = <CFPaymentModes>[];
      components.add(CFPaymentModes.UPI);
      var paymentComponent =
          CFPaymentComponentBuilder().setComponents(components).build();

      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#FF0000")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .build();

      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session!)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();

      cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }

  newPay() async {
    cfPaymentGatewayService = CFPaymentGatewayService();
    cfPaymentGatewayService.setCallback((p0) async {
      print(p0);
    }, (p0, p1) async {
      print(p0);
      print(p1);
    });
    webCheckout();
  }

  webCheckout() async {
    try {
      cfPaymentGatewayService.setCallback(_verifyPayment, _onError);
      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#ff00ff")
          .setNavigationBarTextColor("#ffffff")
          .build();
      var cfWebCheckout = CFWebCheckoutPaymentBuilder()
          .setSession(session!)
          .setTheme(theme)
          .build();
      cfPaymentGatewayService.doPayment(cfWebCheckout);
    } on CFException catch (e) {
      // print(e.message);
      onErrorListener.add(e.message);
    }
  }

  void _verifyPayment(String orderId) {
    onVerifyListener.add(orderId);
    // Logger().d('Verify Payment');
    // print("Verify Payment");
  }

  void _onError(CFErrorResponse errorResponse, String orderId) {
    // print(errorResponse.getMessage());
    onErrorListener.add(errorResponse.getMessage() ?? errorResponse.toString());
    // Logger().e(errorResponse.getMessage());
    // print("Error while making payment");
  }


  StreamController<String> onVerifyListener = StreamController<String>();
  StreamController<String> onErrorListener = StreamController<String>();

  static Future<List<String>> createOrder(
      {required String secretKey,
      required String clientId,
      required double amount,
      required String currency,
  required  Map<String,dynamic> customerData
      }) async {
    // Production -> https://api.cashfree.com/pg/orders
    // Sandbox -> https://sandbox.cashfree.com/pg/orders

    final data = {
      "order_amount": amount,
      "order_currency": currency,
      // "order_currency": "INR",
      "customer_details": customerData,
      "order_meta": {
        "return_url": "https://b8af79f41056.eu.ngrok.io?order_id=order_123",
      }
    };
    final url = environment == CFEnvironment.PRODUCTION ? 'https://api.cashfree.com/pg/orders' : 'https://sandbox.cashfree.com/pg/orders';
    final response = await http.post(
          Uri.parse(url),
          body: json.encode(data),
          headers: {
              'X-Client-Secret': environment == CFEnvironment.PRODUCTION ? secretKey : 'TEST2f871b9ed57ea8731974cfdc377ff7509ca05c76',
              'X-Client-Id': environment == CFEnvironment.PRODUCTION ? clientId : 'TEST430344cefc0908afd64e540c83443034',

            'x-api-version': '2022-09-01',

            "Accept": "application/json",
            "Content-Type": "application/json;charset=utf-8"
          });


      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final orderId = body['cf_order_id'];
        final sessionId = body['payment_session_id'];

        List<String> data = [
        '$orderId', sessionId];
        return data;
      } else {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        throw body['message'];
      }
  }
}
