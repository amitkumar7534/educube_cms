// To parse this JSON data, do
//
//     final feeCollectionModel = feeCollectionModelFromJson(jsonString);

import 'dart:convert';

FeeCollectionModel feeCollectionModelFromJson(String str) => FeeCollectionModel.fromJson(json.decode(str));

String feeCollectionModelToJson(FeeCollectionModel data) => json.encode(data.toJson());

class FeeCollectionModel {
  String? feeStructureName;
  String? feeStructureId;
  String? userCategory;
  String? feeItem;
  String? feeInstallmentId;
  String? feeStartDate;
  String? feeEndDate;
  String? isChequeUnderProcess;
  String? actualAmount;
  String? dueAmount;
  String? fine;
  String? fineId;
  String? fineConcession;
  String? userConcession;
  String? paymentAmount;
  String? feeIds;

  FeeCollectionModel({
    this.feeStructureName,
    this.feeStructureId,
    this.userCategory,
    this.feeItem,
    this.feeInstallmentId,
    this.feeStartDate,
    this.feeEndDate,
    this.isChequeUnderProcess,
    this.actualAmount,
    this.dueAmount,
    this.fine,
    this.fineId,
    this.fineConcession,
    this.userConcession,
    this.paymentAmount,
    this.feeIds,
  });

  FeeCollectionModel copyWith({
    String? feeStructureName,
    String? feeStructureId,
    String? userCategory,
    String? feeItem,
    String? feeInstallmentId,
    String? feeStartDate,
    String? feeEndDate,
    String? isChequeUnderProcess,
    String? actualAmount,
    String? dueAmount,
    String? fine,
    String? fineId,
    String? fineConcession,
    String? userConcession,
    String? paymentAmount,
    String? feeIds,
  }) =>
      FeeCollectionModel(
        feeStructureName: feeStructureName ?? this.feeStructureName,
        feeStructureId: feeStructureId ?? this.feeStructureId,
        userCategory: userCategory ?? this.userCategory,
        feeItem: feeItem ?? this.feeItem,
        feeInstallmentId: feeInstallmentId ?? this.feeInstallmentId,
        feeStartDate: feeStartDate ?? this.feeStartDate,
        feeEndDate: feeEndDate ?? this.feeEndDate,
        isChequeUnderProcess: isChequeUnderProcess ?? this.isChequeUnderProcess,
        actualAmount: actualAmount ?? this.actualAmount,
        dueAmount: dueAmount ?? this.dueAmount,
        fine: fine ?? this.fine,
        fineId: fineId ?? this.fineId,
        fineConcession: fineConcession ?? this.fineConcession,
        userConcession: userConcession ?? this.userConcession,
        paymentAmount: paymentAmount ?? this.paymentAmount,
        feeIds: feeIds ?? this.feeIds,
      );

  factory FeeCollectionModel.fromJson(Map<String, dynamic> json) => FeeCollectionModel(
    feeStructureName: json["fee_structure_name"],
    feeStructureId: json["fee_structure_id"],
    userCategory: json["user_category"],
    feeItem: json["fee_item"],
    feeInstallmentId: json["fee_installment_id"],
    feeStartDate: json["fee_start_date"],
    feeEndDate: json["fee_end_date"],
    isChequeUnderProcess: json["is_cheque_under_process"],
    actualAmount: json["actual_amount"],
    dueAmount: json["due_amount"],
    fine: json["fine"],
    fineId: json["fine_id"],
    fineConcession: json["fine_concession"],
    userConcession: json["user_concession"],
    paymentAmount: json["payment_amount"],
    feeIds: json["fee_ids"],
  );

  Map<String, dynamic> toJson() => {
    "fee_structure_name": feeStructureName,
    "fee_structure_id": feeStructureId,
    "user_category": userCategory,
    "fee_item": feeItem,
    "fee_installment_id": feeInstallmentId,
    "fee_start_date": feeStartDate,
    "fee_end_date": feeEndDate,
    "is_cheque_under_process": isChequeUnderProcess,
    "actual_amount": actualAmount,
    "due_amount": dueAmount,
    "fine": fine,
    "fine_id": fineId,
    "fine_concession": fineConcession,
    "user_concession": userConcession,
    "payment_amount": paymentAmount,
    "fee_ids": feeIds,
  };

  // {
  // "fee_structure_name": "Composite Fee - (Class I) - General (July-24) - Studying",
  // "fee_structure_id": "43995",
  // "user_category": null,
  // "fee_item": "Monthly Composite Fee",
  // "fee_installment_id": "122008",
  // "fee_start_date": "01-07-2024",
  // "fee_end_date": "31-07-2024",
  // "is_cheque_under_process": null,
  // "actual_amount": "6180",
  // "due_amount": null,
  // "fine": "0",
  // "fine_id": "88",
  // "fine_concession": "0",
  // "user_concession": "0",
  // "payment_amount": "6180",
  // "fee_ids": "43995_122008_88"
  // }
}
