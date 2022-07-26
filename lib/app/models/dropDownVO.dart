// To parse this JSON data, do
//
//     final dropDownVo = dropDownVoFromJson(jsonString);

import 'dart:convert';

DropDownVO dropDownVoFromJson(String str) =>
    DropDownVO.fromJson(json.decode(str));

String dropDownVoToJson(DropDownVO data) => json.encode(data.toJson());

class DropDownVO {
  DropDownVO(
      {this.status,
      this.responseCode,
      this.description,
      this.saleStatus,
      this.saleSource,
      this.saleBusinessType,
      this.saleSme,
      this.saleDesignation,
      this.division,
      this.township,
      this.followUpVia});

  String? status;
  String? responseCode;
  String? description;
  List<SaleStatus>? saleStatus;
  List<Sale>? saleSource;
  List<Sale>? saleBusinessType;
  List<Sale>? saleSme;
  List<Sale>? township;
  List<Sale>? division;
  List<SaleDesignation>? saleDesignation;
  List<FollowUpVia>? followUpVia;

  factory DropDownVO.fromJson(Map<String, dynamic> json) => DropDownVO(
        status: json["status"],
        responseCode: json["response_code"],
        description: json["description"],
        saleStatus: List<SaleStatus>.from(
            json["sale_status"].map((x) => SaleStatus.fromJson(x))),
        saleSource:
            List<Sale>.from(json["sale_source"].map((x) => Sale.fromJson(x))),
        saleBusinessType: List<Sale>.from(
            json["sale_business_type"].map((x) => Sale.fromJson(x))),
        saleSme: List<Sale>.from(json["sale_sme"].map((x) => Sale.fromJson(x))),
        division:
            List<Sale>.from(json["division"].map((x) => Sale.fromJson(x))),
        township:
            List<Sale>.from(json["township"].map((x) => Sale.fromJson(x))),
        saleDesignation: List<SaleDesignation>.from(
            json["sale_designation"].map((x) => SaleDesignation.fromJson(x))),
        followUpVia: List<FollowUpVia>.from(
            json["followup_via"].map((x) => FollowUpVia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response_code": responseCode,
        "description": description,
        "sale_status": List<dynamic>.from(saleStatus!.map((x) => x.toJson())),
        "sale_source": List<dynamic>.from(saleSource!.map((x) => x.toJson())),
        "sale_business_type":
            List<dynamic>.from(saleBusinessType!.map((x) => x.toJson())),
        "sale_sme": List<dynamic>.from(saleSme!.map((x) => x.toJson())),
        "division": List<dynamic>.from(division!.map((x) => x.toJson())),
        "township": List<dynamic>.from(township!.map((x) => x.toJson())),
        "sale_designation":
            List<dynamic>.from(saleDesignation!.map((x) => x.toJson())),
        "followup_via": List<dynamic>.from(followUpVia!.map((x) => x.toJson())),
      };
}

class Sale {
  Sale({
    this.key,
    this.value,
  });

  int? key;
  String? value;

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class SaleDesignation {
  SaleDesignation({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory SaleDesignation.fromJson(Map<String, dynamic> json) =>
      SaleDesignation(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class SaleStatus {
  SaleStatus({this.key, this.value, this.weight});

  dynamic key;
  String? value;
  String? weight;

  factory SaleStatus.fromJson(Map<String, dynamic> json) => SaleStatus(
        key: json["key"],
        value: json["value"],
        weight: json['weight'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "weight": weight,
      };
}

class FollowUpVia {
  FollowUpVia({
    this.key,
    this.value,
  });

  dynamic key;
  String? value;
  String? weight;

  factory FollowUpVia.fromJson(Map<String, dynamic> json) => FollowUpVia(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
