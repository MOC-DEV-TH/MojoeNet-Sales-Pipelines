// To parse this JSON data, do
//
//     final leadVo = leadVoFromJson(jsonString);

import 'dart:convert';

LeadVO leadVoFromJson(String str) => LeadVO.fromJson(json.decode(str));

String leadVoToJson(LeadVO data) => json.encode(data.toJson());

class LeadVO {
  LeadVO({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
    this.details,
  });

  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;
  List<Detail>? details;

  factory LeadVO.fromJson(Map<String, dynamic> json) => LeadVO(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
    details: List<Detail>.from(
        json["details"]?.map((x) => Detail.fromJson(x)) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "details": List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    this.lid,
    this.businessName,
    this.status,
    this.firstname,
    this.followupDate,
  });

  String? lid;
  String? businessName;
  String? status;
  String? firstname;
  String? followupDate;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    lid: json["lid"],
    businessName: json["business_name"],
    status: json["status"],
    firstname: json["firstname"],
    followupDate: json["followup_date"],
  );

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "business_name": businessName,
    "status": status,
    "firstname": firstname,
    "followup_date": followupDate ,
  };
}

