import 'package:educube1/network/remote_services.dart';
import 'package:educube1/utils/helpers.dart';

import '../model/academic_year_response_model.dart';
import '../model/footer_res_model.dart';
import '../model/login_content_res_model.dart';
import 'ApiUrls.dart';

class GetRequests {
  GetRequests._();

  static Future<AcademicResModel?> fetchAcademicYear(String? userId) async {
    if(await Helpers.checkConnectivity()){
      var apiResponse =
      await RemoteService.simpleGet('${ApiUrls.academic}$userId');
      if (apiResponse != null) {
        return academicResModelFromJson(apiResponse.response!);
      } else {
        return null;
      }
    }else{
      return null;
    }

  }

  static Future<LoginContentResModel?> loginContent() async {
    if(await Helpers.checkConnectivity()){
    var apiResponse = await RemoteService.simpleGet(ApiUrls.loginContent);
    if (apiResponse != null) {
      return loginContentResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }else{
      return null;
    }
  }


}
