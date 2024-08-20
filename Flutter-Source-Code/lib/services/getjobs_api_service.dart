import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jobconnect_app/constants.dart';
import 'package:jobconnect_app/currentuser.dart';
import 'package:jobconnect_app/models/get_jobs_model.dart';
import 'dart:convert'; 

class GetJobApiService {
  Future<List<JobDetails>?> getJobs() async {
    final requestMessage = jsonEncode(<String, dynamic>{ 
                                                //'Login_Id': loginIdController.text, 
                                                //'Password': pwdController.text, 
                                                  "Login_Id": CurrentUser.Login_Id,
                                                  "Login_Type": CurrentUser.Login_Type,
                                                  "Job_Status": CurrentUser.JobStatusFilter,
                                                  "Jobs_Filter": CurrentUser.JobsFilter,
                                                  "City_Filter": CurrentUser.CityFilter
                                                // Add any other data you want to send in the body 
		                                        }
                           );
                           log('request body ', name: requestMessage);
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getJobsEndpoint);
      var response = await http.post(url, headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8', }, 
      		body: requestMessage
                );
                
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('response body ', name: responseData['body']);
        final dataList = jsonDecode(responseData['body'].replaceAll(r'\"', '"'));
        final dataList3 = jsonEncode(dataList);
        //model = jobDetailsFromJson(dataList3);
        List<JobDetails> model = jobDetailsFromJson(dataList3);
        return model;
      }
    }
    catch (e) {
      log(e.toString());
    }
    return null;
  }
}
