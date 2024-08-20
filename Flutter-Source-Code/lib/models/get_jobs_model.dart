// To parse this JSON data, do
//
//     final jobDetails = jobDetailsFromJson(jsonString);

import 'dart:convert';

List<JobDetails> jobDetailsFromJson(String str) => List<JobDetails>.from(json.decode(str).map((x) => JobDetails.fromJson(x)));

String jobDetailsToJson(List<JobDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobDetails {
    String nameJs;
    String jobDescription;
    String nameJp;
    String jobOpenings;
    String emailJs;
    String jobStatus;
    String jobState;
    String emailJp;
    String jobPincode;
    String loginId;
    String longtitude;
    String loginIdJs;
    String mobileNumberJp;
    String jobId;
    String jobCity;
    String wageMinimum;
    String dateFrom;
    String dateTo;
    String mobileNumberJs;
    String jobStreet;
    String jobType;
    String wageMaximum;
    String lattitude;
    String paymentFrequency;
    String requestedWage;

    JobDetails({
        required this.nameJs,
        required this.jobDescription,
        required this.nameJp,
        required this.jobOpenings,
        required this.emailJs,
        required this.jobStatus,
        required this.jobState,
        required this.emailJp,
        required this.jobPincode,
        required this.loginId,
        required this.longtitude,
        required this.loginIdJs,
        required this.mobileNumberJp,
        required this.jobId,
        required this.jobCity,
        required this.wageMinimum,
        required this.dateFrom,
        required this.dateTo,
        required this.mobileNumberJs,
        required this.jobStreet,
        required this.jobType,
        required this.wageMaximum,
        required this.lattitude,
        required this.paymentFrequency,
        required this.requestedWage,
    });

    factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
        nameJs: json["Name_JS"],
        jobDescription: json["Job_Description"],
        nameJp: json["Name_JP"],
        jobOpenings: json["Job_Openings"],
        emailJs: json["Email_JS"],
        jobStatus: json["Job_Status"],
        jobState: json["Job_State"],
        emailJp: json["Email_JP"],
        jobPincode: json["Job_Pincode"],
        loginId: json["Login_Id"],
        longtitude: json["Longtitude"],
        loginIdJs: json["Login_Id_JS"],
        mobileNumberJp: json["Mobile_Number_JP"],
        jobId: json["Job_Id"],
        jobCity: json["Job_City"],
        wageMinimum: json["Wage_Minimum"],
        dateFrom: json["Date_From"],
        dateTo: json["Date_To"],
        mobileNumberJs: json["Mobile_Number_JS"],
        jobStreet: json["Job_Street"],
        jobType: json["Job_Type"],
        wageMaximum: json["Wage_Maximum"],
        lattitude: json["Lattitude"],
        paymentFrequency: json["Payment_Frequency"],
        requestedWage: json["Requested_Wage"],
    );

    Map<String, dynamic> toJson() => {
        "Name_JS": nameJs,
        "Job_Description": jobDescription,
        "Name_JP": nameJp,
        "Job_Openings": jobOpenings,
        "Email_JS": emailJs,
        "Job_Status": jobStatus,
        "Job_State": jobState,
        "Email_JP": emailJp,
        "Job_Pincode": jobPincode,
        "Login_Id": loginId,
        "Longtitude": longtitude,
        "Login_Id_JS": loginIdJs,
        "Mobile_Number_JP": mobileNumberJp,
        "Job_Id": jobId,
        "Job_City": jobCity,
        "Wage_Minimum": wageMinimum,
        "Date_From": dateFrom,
        "Date_To": dateTo,
        "Mobile_Number_JS": mobileNumberJs,
        "Job_Street": jobStreet,
        "Job_Type": jobType,
        "Wage_Maximum": wageMaximum,
        "Lattitude": lattitude,
        "Payment_Frequency": paymentFrequency,
        "Requested_Wage": requestedWage,
    };
}
