// To parse this JSON data, do
//
//     final jobDetails = jobDetailsFromJson(jsonString);

import 'dart:convert';

List<JobDetails> jobDetailsFromJson(String str) => List<JobDetails>.from(json.decode(str).map((x) => JobDetails.fromJson(x)));

String jobDetailsToJson(List<JobDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobDetails {
    String jobDescription;
    String longtitude;
    String nameJp;
    String jobOpenings;
    String mobileNumberJp;
    String jobId;
    String jobCity;
    String wageMinimum;
    String dateFrom;
    String dateTo;
    String jobStreet;
    String jobType;
    String wageMaximum;
    String jobState;
    String jobStatus;
    String emailJp;
    String lattitude;
    String jobPincode;
    String paymentFrequency;
    String loginId;

    JobDetails({
        required this.jobDescription,
        required this.longtitude,
        required this.nameJp,
        required this.jobOpenings,
        required this.mobileNumberJp,
        required this.jobId,
        required this.jobCity,
        required this.wageMinimum,
        required this.dateFrom,
        required this.dateTo,
        required this.jobStreet,
        required this.jobType,
        required this.wageMaximum,
        required this.jobState,
        required this.jobStatus,
        required this.emailJp,
        required this.lattitude,
        required this.jobPincode,
        required this.paymentFrequency,
        required this.loginId,
    });

    factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
        jobDescription: json["Job_Description"],
        longtitude: json["Longtitude"],
        nameJp: json["Name_JP"],
        jobOpenings: json["Job_Openings"],
        mobileNumberJp: json["Mobile_Number_JP"],
        jobId: json["Job_Id"],
        jobCity: json["Job_City"],
        wageMinimum: json["Wage_Minimum"],
        dateFrom: json["Date_From"],
        dateTo: json["Date_To"],
        jobStreet: json["Job_Street"],
        jobType: json["Job_Type"],
        wageMaximum: json["Wage_Maximum"],
        jobState: json["Job_State"],
        jobStatus: json["Job_Status"],
        emailJp: json["Email_JP"],
        lattitude: json["Lattitude"],
        jobPincode: json["Job_Pincode"],
        paymentFrequency: json["Payment_Frequency"],
        loginId: json["Login_Id"],
    );

    Map<String, dynamic> toJson() => {
        "Job_Description": jobDescription,
        "Longtitude": longtitude,
        "Name_JP": nameJp,
        "Job_Openings": jobOpenings,
        "Mobile_Number_JP": mobileNumberJp,
        "Job_Id": jobId,
        "Job_City": jobCity,
        "Wage_Minimum": wageMinimum,
        "Date_From": dateFrom,
        "Date_To": dateTo,
        "Job_Street": jobStreet,
        "Job_Type": jobType,
        "Wage_Maximum": wageMaximum,
        "Job_State": jobState,
        "Job_Status": jobStatus,
        "Email_JP": emailJp,
        "Lattitude": lattitude,
        "Job_Pincode": jobPincode,
        "Payment_Frequency": paymentFrequency,
        "Login_Id": loginId,
    };
}
