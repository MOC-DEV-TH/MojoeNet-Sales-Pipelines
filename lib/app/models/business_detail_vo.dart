// To parse this JSON data, do
//
//     final businessDetailVo = businessDetailVoFromJson(jsonString);

import 'dart:convert';

BusinessDetailVO businessDetailVoFromJson(String str) => BusinessDetailVO.fromJson(json.decode(str));

String businessDetailVoToJson(BusinessDetailVO data) => json.encode(data.toJson());

class BusinessDetailVO {
  BusinessDetailVO({
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

  factory BusinessDetailVO.fromJson(Map<String, dynamic> json) => BusinessDetailVO(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
    details:json['details']!=null ? Details?.fromJson(json["details"]) : null,
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
    this.lid,
    this.uid,
    this.profileId,
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.contactInformation,
    this.package,
    this.plan,
    this.notes,
    this.installation,
    this.leadSource,
    this.businessType,
    this.businessCategory,
    this.township,
    this.division,
    this.contactno,
    this.businessName,
    this.currentIsp,
    this.potential,
    this.weighted,
    this.followupVia,
    this.followupDate,
    this.estimateFlightdate,
    this.channel,
    this.designation,
    this.compound,
    this.createdBy,
    this.updatedBy,
    this.creationDate,
    this.modifiedDate,
    this.status,
    this.packageTotal,
    this.referrelId,
    this.leadAssign,
    this.isReferal,
    this.discount,
    this.latitude,
    this.longitude,
    this.contractDate,
    this.customerNote,
    this.installationAppointmentDate,
    this.secondaryContactNumber,
    this.businessTypeOther,
    this.designationTypeOther,
    this.meetingNotes,
    this.nextStep,
    this.estContractDate,
    this.estStartDate,
    this.estFollowUpDate
  });

  String? lid;
  dynamic uid;
  dynamic profileId;
  String? firstname;
  dynamic lastname;
  dynamic email;
  String? address;
  dynamic contactInformation;
  dynamic package;
  dynamic plan;
  dynamic notes;
  dynamic installation;
  String? leadSource;
  String? businessType;
  dynamic businessCategory;
  String? township;
  String? division;
  String? contactno;
  String? businessName;
  String? currentIsp;
  String? potential;
  dynamic weighted;
  dynamic followupVia;
  String? followupDate;
  dynamic estimateFlightdate;
  String? channel;
  String? designation;
  String? compound;
  String? createdBy;
  String? updatedBy;
  String? creationDate;
  String? modifiedDate;
  String? status;
  String? packageTotal;
  dynamic referrelId;
  dynamic leadAssign;
  String? isReferal;
  dynamic discount;
  dynamic latitude;
  dynamic longitude;
  dynamic contractDate;
  dynamic installationAppointmentDate;
  dynamic customerNote;
  dynamic secondaryContactNumber;
  dynamic businessTypeOther;
  dynamic designationTypeOther;
  String? meetingNotes;
  String? nextStep;
  String? estContractDate;
  String? estStartDate;
  String? estFollowUpDate;



  factory Details.fromJson(Map<String, dynamic> json) => Details(
    lid: json["lid"],
    uid: json["uid"],
    profileId: json["profile_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    address: json["address"],
    contactInformation: json["contact_information"],
    package: json["package"],
    plan: json["plan"],
    notes: json["notes"],
    installation: json["installation"],
    leadSource: json["lead_source"],
    businessType: json["business_type"],
    businessCategory: json["business_category"],
    township: json["township"],
    division: json["division"],
    contactno: json["contactno"],
    businessName: json["business_name"],
    currentIsp: json["current_isp"],
    potential: json["potential"],
    weighted: json["weighted"],
    followupVia: json["followup_via"],
    followupDate: json["followup_date"],
    estimateFlightdate: json["estimate_flightdate"],
    channel: json["channel"],
    designation: json["designation"],
    compound: json["compound"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    creationDate:json["creation_date"],
    modifiedDate: json["modified_date"],
    status: json["status"],
    packageTotal: json["package_total"],
    referrelId: json["referrel_id"],
    leadAssign: json["lead_assign"],
    isReferal: json["isReferal"],
    discount: json["discount"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    contractDate: json["contract_date"],
    installationAppointmentDate: json["installation_appointment_date"],
    customerNote: json["customer_note"],
    secondaryContactNumber: json['secondary_contact_number'],
    businessTypeOther: json["business_type_other"],
    designationTypeOther: json["designation_other"],
    meetingNotes: json["meeting_notes"],
    nextStep: json["next_step"],
    estContractDate: json["est_contract_date"],
    estStartDate: json["est_start_date"],
    estFollowUpDate: json["follow_up_date"],
  );

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "uid": uid,
    "profile_id": profileId,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "address": address,
    "contact_information": contactInformation,
    "package": package,
    "plan": plan,
    "notes": notes,
    "installation": installation,
    "lead_source": leadSource,
    "business_type": businessType,
    "business_category": businessCategory,
    "township": township,
    "division": division,
    "contactno": contactno,
    "business_name": businessName,
    "current_isp": currentIsp,
    "potential": potential,
    "weighted": weighted,
    "followup_via": followupVia,
    "followup_date": followupDate,
    "estimate_flightdate": estimateFlightdate,
    "channel": channel,
    "designation": designation,
    "compound": compound,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "creation_date": creationDate,
    "modified_date": modifiedDate,
    "status": status,
    "package_total": packageTotal,
    "referrel_id": referrelId,
    "lead_assign": leadAssign,
    "isReferal": isReferal,
    "discount": discount,
    "latitude": latitude,
    "longitude": longitude,
    "contract_date": contractDate,
    "installation_appointment_date": installationAppointmentDate,
    "customer_note": customerNote,
    "secondary_contact_number" : secondaryContactNumber,
    "designation_other": designationTypeOther,
    "business_type_other": businessTypeOther,
    "meeting_notes": meetingNotes,
    "next_step": nextStep,
    "est_contract_date": estContractDate,
    "est_start_date": estStartDate,
    "follow_up_date": estFollowUpDate,
  };
}
