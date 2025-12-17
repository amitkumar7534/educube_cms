
import 'dart:convert';


LoginMobileRes loginMobileResModelFromJson(String str) =>
    LoginMobileRes.fromJson(json.decode(str));

// String loginMobileResModelToJson(LoginMobileRes data) => json.encode(data.toJson());


class LoginMobileRes {
  final MobileResponse? mobileResponse;


  LoginMobileRes({
     this.mobileResponse,
  });


  factory LoginMobileRes.fromJson(Map<String, dynamic> json){
    return LoginMobileRes(
      mobileResponse: json["MobileResponse"] == null ? null : MobileResponse.fromJson(json["MobileResponse"]),
    );
  }

 /* Map<String, dynamic> toJson() => {
    "MobileResponse": mobileResponse?.toJson(),
  };
*/
}

class MobileResponse {
  MobileResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.isMobile,
    required this.objMobileAuthResponse,
  });

  final bool? status;
  final int? statusCode;
  final String? message;
  final bool? isMobile;
  final ObjMobileAuthResponse? objMobileAuthResponse;

  factory MobileResponse.fromJson(Map<String, dynamic> json){
    return MobileResponse(
      status: json["Status"],
      statusCode: json["StatusCode"],
      message: json["Message"],
      isMobile: json["IsMobile"],
      objMobileAuthResponse: json["objMobileAuthResponse"] == null ? null : ObjMobileAuthResponse.fromJson(json["objMobileAuthResponse"]),
    );
  }

}

class ObjMobileAuthResponse {
  ObjMobileAuthResponse({
    required this.otpNumber,
    required this.userId,
  });

  final String? otpNumber;
  final String? userId;

  factory ObjMobileAuthResponse.fromJson(Map<String, dynamic> json){
    return ObjMobileAuthResponse(
      otpNumber: json["otp_number"],
      userId: json["user_id"],
    );
  }



}
