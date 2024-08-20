// To parse this JSON data, do
//
//     final jobtypes = jobtypesFromJson(jsonString);

import 'dart:convert';

List<Jobtypes> jobtypesFromJson(String str) => List<Jobtypes>.from(json.decode(str).map((x) => Jobtypes.fromJson(x)));

String jobtypesToJson(List<Jobtypes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jobtypes {
    String jobType;

    Jobtypes({
        required this.jobType,
    });

    factory Jobtypes.fromJson(Map<String, dynamic> json) => Jobtypes(
        jobType: json["Job_Type"],
    );

    Map<String, dynamic> toJson() => {
        "Job_Type": jobType,
    };
}