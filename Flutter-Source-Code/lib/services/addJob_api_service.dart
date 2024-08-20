import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jobconnect_app/constants.dart';
import 'dart:convert'; 

class PostNewJobApiService {
  Future<String> addJob(String newrequest) async {
    try {
      //log('request to be sent is ', name: newrequest);
      var url = Uri.parse(ApiConstants.addJobEndPoint);
      var response = await http.post(url, headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8', }, 
      		body: newrequest
                );
            //    log('response received: ', name: response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
      //  log('response body: ', name: responseData['body']);
        final dataList4 = jsonDecode(responseData['body']);
        //final dataList = jsonDecode(responseData['body'].replaceAll(r'\"', '"'));
        final dataList3 = dataList4['Status'];
        return dataList3;
      }
    }
    catch (e) {
      log(e.toString());
    }
    return "";
  }
}
