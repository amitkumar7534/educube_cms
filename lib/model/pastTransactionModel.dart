// To parse this JSON data, do
//
//     final pastTransactionModel = pastTransactionModelFromJson(jsonString);

import 'dart:convert';

PastTransactionModel pastTransactionModelFromJson(String str) => PastTransactionModel.fromJson(json.decode(str));

String pastTransactionModelToJson(PastTransactionModel data) => json.encode(data.toJson());

class PastTransactionModel {
  String? feePaidDate;
  String? feeAmount;
  String? fineAmount;
  String? feeReceiptNo;
  String? modeOfPayment;
  String? status;
  String? onlineTransactionId;
  String? chequeClearedDate;
  String? voucherId;

  PastTransactionModel({
    this.feePaidDate,
    this.feeAmount,
    this.fineAmount,
    this.feeReceiptNo,
    this.modeOfPayment,
    this.status,
    this.onlineTransactionId,
    this.chequeClearedDate,
    this.voucherId,
  });

  PastTransactionModel copyWith({
    String? feePaidDate,
    String? feeAmount,
    String? fineAmount,
    String? feeReceiptNo,
    String? modeOfPayment,
    String? status,
    String? onlineTransactionId,
    String? chequeClearedDate,
    String? voucherId,
  }) =>
      PastTransactionModel(
        feePaidDate: feePaidDate ?? this.feePaidDate,
        feeAmount: feeAmount ?? this.feeAmount,
        fineAmount: fineAmount ?? this.fineAmount,
        feeReceiptNo: feeReceiptNo ?? this.feeReceiptNo,
        modeOfPayment: modeOfPayment ?? this.modeOfPayment,
        status: status ?? this.status,
        onlineTransactionId: onlineTransactionId ?? this.onlineTransactionId,
        chequeClearedDate: chequeClearedDate ?? this.chequeClearedDate,
        voucherId: voucherId ?? this.voucherId,
      );

  factory PastTransactionModel.fromJson(Map<String, dynamic> json) => PastTransactionModel(
    feePaidDate: json["Fee_Paid_Date"],
    feeAmount: json["Fee_Amount"],
    fineAmount: json["Fine_Amount"],
    feeReceiptNo: json["Fee_Receipt_No"],
    modeOfPayment: json["Mode_of_Payment"],
    status: json["Status"],
    onlineTransactionId: json["Online_Transaction_ID"],
    chequeClearedDate: json["Cheque_Cleared_Date"],
    voucherId: json["Voucher_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Fee_Paid_Date": feePaidDate,
    "Fee_Amount": feeAmount,
    "Fine_Amount": fineAmount,
    "Fee_Receipt_No": feeReceiptNo,
    "Mode_of_Payment": modeOfPayment,
    "Status": status,
    "Online_Transaction_ID": onlineTransactionId,
    "Cheque_Cleared_Date": chequeClearedDate,
    "Voucher_Id": voucherId,
  };
}
