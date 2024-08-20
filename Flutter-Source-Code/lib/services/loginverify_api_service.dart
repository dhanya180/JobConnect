import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jobconnect_app/constants.dart';
import 'dart:convert';

import 'package:jobconnect_app/currentuser.dart'; 

class PostLoginVerifyApiService {
  Future<String> verifyLogin(String loginrequest) async {
    try {
      log('request to be sent is ', name: loginrequest);
      var url = Uri.parse(ApiConstants.loginVerifyEndpoint);
      var response = await http.post(url, headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8', }, 
      		body: loginrequest
                );
                // log('response received: ', name: response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('response body: ', name: responseData['body']);
        final dataList4 = jsonDecode(responseData['body']);
        //final dataList = jsonDecode(responseData['body'].replaceAll(r'\"', '"'));
        final dataList3 = dataList4['Status'];
        if ((dataList3 == "Success") || (dataList3 == "Email not yet verified"))
        {
                  CurrentUser.Login_Id = dataList4['Login_Id'];
              CurrentUser.Mobile_Number =  dataList4['Mobile_Number'];
              CurrentUser.Email = dataList4['Email'];
              CurrentUser.User_Name = dataList4['User_Name']; 
              log('Login Status: ', name: dataList4["Mobile_Number"]);

        }

        return dataList3;
      }
    }
    catch (e) {
      log(e.toString());
    }
    return "";
  }
}
