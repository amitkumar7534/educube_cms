// To parse this JSON data, do
//
//     final footerResModel = footerResModelFromJson(jsonString);

import 'dart:convert';

FooterResModel footerResModelFromJson(String str) => FooterResModel.fromJson(json.decode(str));

String footerResModelToJson(FooterResModel data) => json.encode(data.toJson());

class FooterResModel {
  HeaderFooterResponse? headerFooterResponse;

  FooterResModel({
    this.headerFooterResponse,
  });

  factory FooterResModel.fromJson(Map<String, dynamic> json) => FooterResModel(
    headerFooterResponse: json["Header_FooterResponse"] == null ? null : HeaderFooterResponse.fromJson(json["Header_FooterResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "Header_FooterResponse": headerFooterResponse?.toJson(),
  };
}

class HeaderFooterResponse {
  bool? status;
  int? statusCode;
  String? message;
  HeaderFooterDetail? headerFooterDetail;

  HeaderFooterResponse({
    this.status,
    this.statusCode,
    this.message,
    this.headerFooterDetail,
  });

  factory HeaderFooterResponse.fromJson(Map<String, dynamic> json) => HeaderFooterResponse(
    status: json["Status"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    headerFooterDetail: json["header_footerDetail"] == null ? null : HeaderFooterDetail.fromJson(json["header_footerDetail"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "StatusCode": statusCode,
    "Message": message,
    "header_footerDetail": headerFooterDetail?.toJson(),
  };
}

class HeaderFooterDetail {
  String? productLogo;
  String? clientLogo;
  String? footerContent;
  String? menuFooterContent;

  HeaderFooterDetail({
    this.productLogo,
    this.clientLogo,
    this.footerContent,
    this.menuFooterContent,
  });

  factory HeaderFooterDetail.fromJson(Map<String, dynamic> json) => HeaderFooterDetail(
    productLogo: json["Product_Logo"],
    clientLogo: json["Client_Logo"],
    footerContent: json["Footer_Content"],
    menuFooterContent: json["Menu_Footer_Content"],
  );

  Map<String, dynamic> toJson() => {
    "Product_Logo": productLogo,
    "Client_Logo": clientLogo,
    "Footer_Content": footerContent,
    "Menu_Footer_Content": menuFooterContent,
  };
}
