import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jobconnect_app/constants.dart';
import 'package:jobconnect_app/models/get_jobtypes_model.dart';
import 'dart:convert'; 

class PostJobTypesApiService {

  Future<List<Jobtypes>?> getJobTypes() async {
    try {

      var url = Uri.parse(ApiConstants.jobTypesEndpoint);
      var response = await http.post(url, headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8', }, 
    //
                );
                // log('response received: ', name: response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        //log('log me', name: responseData['body']);
        final dataList = jsonDecode(responseData['body'].replaceAll(r'\"', '"'));
        final dataList3 = jsonEncode(dataList);
        List<Jobtypes> model = jobtypesFromJson(dataList3);

        return model;
      }
    }
    catch (e) {
      log(e.toString());
    }
    return null;
  }
}