import 'dart:convert';

LoginVO loginVoFromJson(String str) =>
    LoginVO.fromJson(json.decode(str));

String loginVoToJson(LoginVO data) => json.encode(data.toJson());

class LoginVO {
  LoginVO({
    required this.status,
    required this.description,
    required this.token,
    required this.uid,
  });

  String? status;
  String? responseCode;
  String? description;
  String? token;
  String? uid;

  factory LoginVO.fromJson(Map<String, dynamic> json) => LoginVO(
        status: json["status"],
        description: json["description"],
        uid: json["uid"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "description": description,
        "uid": uid,
        "token": token,
      };
}
