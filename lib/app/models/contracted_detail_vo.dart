import 'dart:convert';

ContractedDetailVo contractedDetailVoFromJson(String str) => ContractedDetailVo.fromJson(json.decode(str));

String contractedDetailVoToJson(ContractedDetailVo data) => json.encode(data.toJson());

class ContractedDetailVo {
  ContractedDetailVo({
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
  Details? details;

  factory ContractedDetailVo.fromJson(Map<String, dynamic> json) => ContractedDetailVo(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "details": details!.toJson(),
  };
}

class Details {
  Details({
    this.profileId,
    this.division,
    this.township,
    this.plan,
    this.package,
    this.firstname,
    this.phone1,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.installationAppointmentDate,
    this.contractedDate,
    this.notes,
    this.phone2,
    this.businessName
  });

  String? profileId;
  dynamic division;
  String? township;
  dynamic plan;
  dynamic package;
  String? firstname;
  dynamic phone1;
  dynamic phone2;
  dynamic address;
  String? email;
  String? latitude;
  String? longitude;
  String? contractedDate;
  String? installationAppointmentDate;
  String? notes;
  dynamic businessName;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    profileId: json["profile_id"],
    division: json["division"],
    township: json["township"],
    plan: json["plan"],
    package: json["package"],
    firstname: json["firstname"],
    phone1: json["phone_1"],
    phone2: json["phone_2"],
    email: json["email"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    installationAppointmentDate: json["installation"],
    contractedDate: json["contract_date"],
    notes: json["notes"],
    businessName: json["business_name"],
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "division": division,
    "township": township,
    "plan": plan,
    "package": package,
    "firstname": firstname,
    "phone_1": phone1,
    "phone_2": phone2,
    "email": email,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "installation": installationAppointmentDate,
    "contract_date": contractedDate,
    "notes": notes,
    "business_name": businessName,

  };
}
