import 'package:educube1/bindings/event_binding.dart';
import 'package:educube1/bindings/home_binding.dart';
import 'package:educube1/bindings/parent_profile_binding.dart';
import 'package:educube1/bindings/teacher_binding.dart';
import 'package:educube1/bindings/timetable_binding.dart';
import 'package:educube1/view/pages/attendance/attendance_screen.dart';
import 'package:educube1/view/pages/change_password/change_password_screen.dart';
import 'package:educube1/view/pages/event/holiday_event_screen.dart';
import 'package:educube1/view/pages/fees/viewFeeReceipt.dart';
import 'package:educube1/view/pages/home/home_screen.dart';
import 'package:educube1/view/pages/login/verify_otp.dart';
import 'package:educube1/view/pages/performance/performanceListScreen.dart';
import 'package:educube1/view/pages/profile/parent_profile_screen.dart';
import 'package:educube1/view/pages/progress_report/progress_report_screen.dart';
import 'package:educube1/view/pages/teacher/my_teacher_screen.dart';
import 'package:get/get.dart';
import '../bindings/attendance_binding.dart';
import '../bindings/change_password_binding.dart';
import '../bindings/dashboard_binding.dart';
import '../bindings/fees_binding.dart';
import '../bindings/forgot_password_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/make_payment_binding.dart';
import '../bindings/notification_binding.dart';
import '../bindings/performance_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/progress_report_binding.dart';
import '../bindings/routes_binding.dart';
import '../bindings/verify_binding.dart';
import '../view/pages/dashboard/dashboard_screen.dart';
import '../view/pages/fees/fees_screen.dart';
import '../view/pages/forgot/forgot_password_screen.dart';
import '../view/pages/login/login_screen.dart';
import '../view/pages/make_payment/make_payment_screen.dart';
import '../view/pages/notification/notification_screen.dart';
import '../view/pages/performance/performance_screen.dart';
import '../view/pages/profile/profile_screen.dart';
import '../view/pages/routes/routes_screen.dart';
import '../view/pages/splash/splash_screen.dart';
import '../view/pages/timetable/timetable_screen.dart';
import 'app_routes.dart';

class AppPages {
  static Duration transitionDuration = const Duration(milliseconds: 150);
  static var pages = <GetPage>[
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        name: AppRoutes.routeSplash,
        page: () => SplashScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: VerifyBinding(),
        name: AppRoutes.routeVerify,
        page: () => VerifyOtp()),

    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: LoginBinding(),
        name: AppRoutes.routeLogin,
        page: () => LoginScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: ForgotPasswordBinding(),
        name: AppRoutes.routeForgotPassword,
        page: () => ForgotPassWordScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: HomeBinding(),
        name: AppRoutes.routeProfile,
        page: () => ProfileScreen()),


    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: HomeBinding(),
        name: AppRoutes.routeHome,
        page: () => HomeScreen()),

    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: ParentProfileBinding(),
        name: AppRoutes.routeParentProfile,
        page: () => ParentProfileScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: DashBoardBinding(),
        name: AppRoutes.routeDashBoard,
        page: () => DashBoardScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: NotificationBinding(),
        name: AppRoutes.routeNotification,
        page: () => NotificationScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: ChangePasswordBinding(),
        name: AppRoutes.routeChangePassword,
        page: () => ChangePasswordScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: AttendanceBinding(),
        name: AppRoutes.routeAttendance,
        page: () => AttendanceScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: PerformanceBinding(),
        name: AppRoutes.routePerformance,
        page: () => PerformanceListScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: PerformanceBinding(),
        name: AppRoutes.routePerformanceSingle,
        page: () => PerformanceScreen()),

    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: TimetableBinding(),
        name: AppRoutes.routeTimetable,
        page: () => TimeTableScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: FeesBinding(),
        name: AppRoutes.routeFees,
        page: () => FeesScreen()),


    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: TeacherBinding(),
        name: AppRoutes.routeTeacher,
        page: () => MyTeachersScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: FeesBinding(),
        name: AppRoutes.routeFeesViewReceipt,
        page: () => ViewFeeReceipt()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: RoutesBinding(),
        name: AppRoutes.routeRoutesScreen,
        page: () => RoutesScreen()),

    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: EventBinding(),
        name: AppRoutes.routeEventScreen,
        page: () => HolidayEventScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: ProgressReportBinding(),
        name: AppRoutes.routeProgressReportScreen,
        page: () => ProgressReportScreen()),
    GetPage(
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
        binding: MakePaymentBinding(),
        name: AppRoutes.routeMakePaymentScreen,
        page: () => MakePaymentScreen()),
  ].obs;
}
