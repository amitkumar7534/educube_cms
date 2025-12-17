// To parse this JSON data, do
//
//     final profileResModel = profileResModelFromJson(jsonString);

import 'dart:convert';

ProfileResModel profileResModelFromJson(String str) => ProfileResModel.fromJson(json.decode(str));

String profileResModelToJson(ProfileResModel data) => json.encode(data.toJson());

class ProfileResModel {
  final ProfileResponse? profileResponse;

  ProfileResModel({
    this.profileResponse,
  });

  factory ProfileResModel.fromJson(Map<String, dynamic> json) => ProfileResModel(
    profileResponse: json["ProfileResponse"] == null ? null : ProfileResponse.fromJson(json["ProfileResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "ProfileResponse": profileResponse?.toJson(),
  };
}

class ProfileResponse {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? username;
  final String? gender;
  final String? dateOfBirth;
  final String? userStatus;
  final String? roleName;
  final String? emergencyContactNo;
  final String? phoneNo;
  final String? mobileNo;
  final String? emailId;
  final String? alternateEmailId;
  final String? houseNo;
  final String? buildingName;
  final String? streetName;
  final String? village;
  final String? zip;
  final String? city;
  final String? state;
  final String? country;
  final String? imagePath;
  final String? standard;
  final String? section;
  final String? photo;
  final String? sign;
  final dynamic aadhaarNo;
  final String? religion;
  final String? caste;
  final String? subCaste;
  final String? grNumber;
  final String? houseName;
  final String? schoolName;
  final TherInfo? fatherInfo;
  final TherInfo? motherInfo;

  ProfileResponse({
    this.firstName,
    this.middleName,
    this.lastName,
    this.username,
    this.gender,
    this.dateOfBirth,
    this.userStatus,
    this.roleName,
    this.emergencyContactNo,
    this.phoneNo,
    this.mobileNo,
    this.emailId,
    this.alternateEmailId,
    this.houseNo,
    this.buildingName,
    this.streetName,
    this.village,
    this.zip,
    this.city,
    this.state,
    this.country,
    this.imagePath,
    this.standard,
    this.section,
    this.photo,
    this.sign,
    this.aadhaarNo,
    this.religion,
    this.caste,
    this.subCaste,
    this.grNumber,
    this.houseName,
    this.schoolName,
    this.fatherInfo,
    this.motherInfo,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    username: json["username"],
    gender: json["gender"],
    dateOfBirth: json["date_of_birth"],
    userStatus: json["user_status"],
    roleName: json["role_name"],
    emergencyContactNo: json["emergency_contact_no"],
    phoneNo: json["phone_no"],
    mobileNo: json["mobile_no"],
    emailId: json["email_id"],
    alternateEmailId: json["alternate_email_id"],
    houseNo: json["house_no"],
    buildingName: json["building_name"],
    streetName: json["street_name"],
    village: json["village"],
    zip: json["zip"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    imagePath: json["image_path"],
    standard: json["standard"],
    section: json["section"],
    photo: json["Photo"],
    sign: json["Sign"],
    aadhaarNo: json["aadhaar_no"],
    religion: json["religion"],
    caste: json["caste"],
    subCaste: json["sub_caste"],
    grNumber: json["gr_number"],
    houseName: json["house_name"],
    schoolName: json["school_name"],
    fatherInfo: json["father_Info"] == null ? null : TherInfo.fromJson(json["father_Info"]),
    motherInfo: json["mother_Info"] == null ? null : TherInfo.fromJson(json["mother_Info"]),
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "username": username,
    "gender": gender,
    "date_of_birth": dateOfBirth,
    "user_status": userStatus,
    "role_name": roleName,
    "emergency_contact_no": emergencyContactNo,
    "phone_no": phoneNo,
    "mobile_no": mobileNo,
    "email_id": emailId,
    "alternate_email_id": alternateEmailId,
    "house_no": houseNo,
    "building_name": buildingName,
    "street_name": streetName,
    "village": village,
    "zip": zip,
    "city": city,
    "state": state,
    "country": country,
    "image_path": imagePath,
    "standard": standard,
    "section": section,
    "Photo": photo,
    "Sign": sign,
    "aadhaar_no": aadhaarNo,
    "religion": religion,
    "caste": caste,
    "sub_caste": subCaste,
    "gr_number": grNumber,
    "house_name": houseName,
    "school_name": schoolName,
    "father_Info": fatherInfo?.toJson(),
    "mother_Info": motherInfo?.toJson(),
  };
}

class TherInfo {
  final String? name;
  final String? contactNumber;
  final DesignationDetails? designationDetails;
  final String? emailId;
  final String? imagePath;

  TherInfo({
    this.name,
    this.contactNumber,
    this.designationDetails,
    this.emailId,
    this.imagePath,
  });

  factory TherInfo.fromJson(Map<String, dynamic> json) => TherInfo(
    name: json["Name"],
    contactNumber: json["ContactNumber"],
    designationDetails: json["DesignationDetails"] == null ? null : DesignationDetails.fromJson(json["DesignationDetails"]),
    emailId: json["EmailId"],
    imagePath: json["Image_path"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "ContactNumber": contactNumber,
    "DesignationDetails": designationDetails?.toJson(),
    "EmailId": emailId,
    "Image_path": imagePath,
  };
}

class DesignationDetails {
  final String? id;
  final String? value;

  DesignationDetails({
    this.id,
    this.value,
  });

  factory DesignationDetails.fromJson(Map<String, dynamic> json) => DesignationDetails(
    id: json["Id"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Value": value,
  };
}
