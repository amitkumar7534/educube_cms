class UserDetails {
  final String? baseUrl;
  final String? baseUrlPath;
  final String? uId;
  final String? refE1UserId;
  final String? uName;
  final String? username;
  final String? refE1RoleId;
  final String? roleId;
  final String? roleName;
  final String? schoolId;
  final String? schoolName;
  final String? institutionId;
  final String? institutionName;
  final String? tallyCompanyName;
  final String? tallyCostcenterName;
  final dynamic tallyBankName;
  final String? shortName;
  final String? logoPath;
  final String? mobileNo;
  final String? emailId;
  String? currentAcademicYear;

  UserDetails({
    this.baseUrl,
    this.baseUrlPath,
    this.uId,
    this.refE1UserId,
    this.uName,
    this.username,
    this.refE1RoleId,
    this.roleId,
    this.roleName,
    this.schoolId,
    this.schoolName,
    this.institutionId,
    this.institutionName,
    this.tallyCompanyName,
    this.tallyCostcenterName,
    this.tallyBankName,
    this.shortName,
    this.logoPath,
    this.mobileNo,
    this.emailId,
    this.currentAcademicYear,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    baseUrl: json["base_url"],
    baseUrlPath: json["base_url_path"],
    uId: json["u_id"],
    refE1UserId: json["ref_e1_user_id"],
    uName: json["u_name"],
    username: json["username"],
    refE1RoleId: json["ref_e1_role_id"],
    roleId: json["role_id"],
    roleName: json["role_name"],
    schoolId: json["school_id"],
    schoolName: json["school_name"],
    institutionId: json["institution_id"],
    institutionName: json["institution_name"],
    tallyCompanyName: json["tally_company_name"],
    tallyCostcenterName: json["tally_costcenter_name"],
    tallyBankName: json["tally_bank_name"],
    shortName: json["short_name"],
    logoPath: json["logo_path"],
    mobileNo: json["mobile_no"],
    emailId: json["email_id"],
    currentAcademicYear: json["current_academic_year"],
  );

  Map<String, dynamic> toJson() => {
    "base_url": baseUrl,
    "base_url_path": baseUrlPath,
    "u_id": uId,
    "ref_e1_user_id": refE1UserId,
    "u_name": uName,
    "username": username,
    "ref_e1_role_id": refE1RoleId,
    "role_id": roleId,
    "role_name": roleName,
    "school_id": schoolId,
    "school_name": schoolName,
    "institution_id": institutionId,
    "institution_name": institutionName,
    "tally_company_name": tallyCompanyName,
    "tally_costcenter_name": tallyCostcenterName,
    "tally_bank_name": tallyBankName,
    "short_name": shortName,
    "logo_path": logoPath,
    "mobile_no": mobileNo,
    "email_id": emailId,
    "current_academic_year": currentAcademicYear,
  };
}