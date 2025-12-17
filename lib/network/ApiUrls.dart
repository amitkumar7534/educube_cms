class ApiUrls {
  ApiUrls._();

 // static const String baseUrl = 'https://cms.educube.net/Educube_Api/';
  static const String baseUrl = 'https://cmsapi.educube.net/Educube_cms_api/';
  static const userLogin = 'api/AuthLogin';
  static const userLoginUsingMobile = 'api/CheckMobile';
  static const userLoginUsingSSO = 'api/GoogleSSOUsers';
  static const verifyOtp = 'api/OTPVerification';
  static const getSiblingDetails = 'api/Profile/GetSibling';
  static const getTeacher = 'api/Teacher/GetClassAndSectionsWiseTeachers';
  static const getClassTeacher = 'api/Teacher/GetSubjectWiseAssignTeachers';
  static const checkEmail = 'api/user/check-email';
  static const requestOtp = 'api/user/request-otp';
  static const signup = 'api/user/signup';
  static const forgotPassword = 'api/forgotpassword';
  static const changeForgotPassword = 'api/user/change-forget-password';
  static const fetchShops = 'api/user/get-business';
  static const fetchShopDetail = 'api/user/get-business/';
  static const fetchProfessionals = 'api/user/professional/';
  static const fetchServices = 'api/user/get-business-services/';
  static const userProfile = 'api/Profile/Get';
  static const getResetPassword = 'api/ChangePassword/changepassword';
  static const resetPassword = 'api/ResetPassword/UpdatePassword';
  static const userNotification = 'api/Notification/Get';
  static const academic = '/api/AcademicYear/';
  static const notificationToggle = 'api/Device/UpdateNotification';
  static const userStandard = 'api/Standard/Get';
  static const getMonth = 'api/Month/Get';
  static const getSessionDetails = 'api/AttendanceSession/Get';
  static const getAttendance = 'api/Attendance/Get';
  static const getTimeTable = 'api/TimeTable/Get';
  static const getEvents = 'api/HolidayEvent/Get';
  // https://cms.educube.net/Educube_Api/api/Performance/Get'
  static const getRoutes = 'api/Route/Get';
  static const getPerformance = 'api/Performance/Get';
  static const getTerms = 'api/Term/Get';

  static const getPastTransaction = 'api/PastTransaction';
  static const getPastTransactionReceipt = 'api/PastTransactionReceipt';
  static const getFeeMonth = 'api/FeeMonth';
  static const getFeeCollection = 'api/FeeCollection';
  static const saveFcmToken = 'api/Device/Save';

  static const getPaymentSession = 'api/CashFreeCredentials/Get';
  static const updatePaymentResponse = 'api/CashFree/UpdateOrder';
  static const prePayment = 'api/CashFree/CreateOrder';
  static const loginContent = 'api/Login_Content/Get';
  static const footerContent = 'api/Header_Footer/Get';
  static const getPermission = 'api/Gateway/Permission';


}
