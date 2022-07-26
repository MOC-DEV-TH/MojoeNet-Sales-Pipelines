import 'dart:convert';

ActivityOverviewVO activityOverviewVoFromJson(String str) => ActivityOverviewVO.fromJson(json.decode(str));

String activityOverviewVoToJson(ActivityOverviewVO data) => json.encode(data.toJson());

class ActivityOverviewVO {
  ActivityOverviewVO({
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

  factory ActivityOverviewVO.fromJson(Map<String, dynamic> json) => ActivityOverviewVO(
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
    "details": details?.toJson(),
  };
}

class Details {
  Details({
    this.dailyFollowUpData,
    this.weeklyFollowUpData,
    this.dailyAppointmentData,
    this.weeklyAppointmentData,
  });

  List<ActivityVO>? dailyFollowUpData;
  List<ActivityVO>? weeklyFollowUpData;
  List<ActivityVO>? dailyAppointmentData;
  List<ActivityVO>? weeklyAppointmentData;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    dailyFollowUpData: List<ActivityVO>.from(json["daily_follow_up_data"].map((x) => ActivityVO.fromJson(x))),
    weeklyFollowUpData: List<ActivityVO>.from(json["weekly_follow_up_data"].map((x) => ActivityVO.fromJson(x))),
    dailyAppointmentData: List<ActivityVO>.from(json["daily_appointment_data"].map((x) => ActivityVO.fromJson(x))),
    weeklyAppointmentData: List<ActivityVO>.from(json["weekly_appointment_data"].map((x) => ActivityVO.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "daily_follow_up_data": List<dynamic>.from(dailyFollowUpData!.map((x) => x.toJson())),
    "weekly_follow_up_data": List<dynamic>.from(weeklyFollowUpData!.map((x) => x.toJson())),
    "daily_appointment_data": List<dynamic>.from(dailyAppointmentData!.map((x) => x.toJson())),
    "weekly_appointment_data": List<dynamic>.from(weeklyAppointmentData!.map((x) => x.toJson())),
  };
}

class ActivityVO {
  ActivityVO({
    this.lid,
    this.followupDate,
    this.businessName,
    this.status,
    this.followupVia,
  });

  String? lid;
  String? followupDate;
  String? businessName;
  String? status;
  dynamic followupVia;

  factory ActivityVO.fromJson(Map<String, dynamic> json) => ActivityVO(
    lid: json["lid"],
    followupDate: json["followup_date"],
    businessName: json["business_name"],
    status: json["status"],
    followupVia: json["followup_via"],
  );

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "followup_date": followupDate,
    "business_name": businessName,
    "status": status,
    "followup_via": followupVia,
  };
}

