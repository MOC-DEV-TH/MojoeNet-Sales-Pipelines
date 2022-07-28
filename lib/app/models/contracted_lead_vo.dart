// To parse this JSON data, do
//
//     final contractedLeadVo = contractedLeadVoFromJson(jsonString);

import 'dart:convert';

import 'package:sales_pipeline/app/models/leadVO.dart';

ContractedLeadVo contractedLeadVoFromJson(String str) => ContractedLeadVo.fromJson(json.decode(str));

String contractedLeadVoToJson(ContractedLeadVo data) => json.encode(data.toJson());

class ContractedLeadVo {
  ContractedLeadVo({
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

  factory ContractedLeadVo.fromJson(Map<String, dynamic> json) => ContractedLeadVo(
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
    this.firstName,
    this.status,
    this.contactInformation,
  });

  String? firstName;
  String? status;
  String? contactInformation;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    firstName: json["firstname"] == null ? null : json["firstname"],
    status: json["status"],
    contactInformation: json["contact_information"] == null ? null : json["contact_information"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstName == null ? null : firstName,
    "status": status,
    "contact_information": contactInformation == null ? null : contactInformation,
  };
}
