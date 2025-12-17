
import 'dart:convert';
import 'package:http/http.dart' as http;

const String url = "https://cms.educube.net/Educube_Api/api/Attendance/Get";

class Api{
  
  static  Future<Map<String, dynamic>?> post(String url, Map<String,String> data)async{
    try{
      var client = http.Client();
      final response = await client.post(Uri.parse(url),body: data);
      if(response.statusCode == 200){
        final body = jsonDecode(response.body) as Map<String,dynamic>;
        final status = body['AttendanceResponse'];
        if(status['Status']){
          return body;
        }else{
          throw Exception(status['Message']);
        }
      }
    }catch(e){
      rethrow;
    }

  }
}


