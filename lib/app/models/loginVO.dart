import 'dart:convert';

LoginVo loginVoFromJson(String str) =>
    LoginVo.fromJson(json.decode(str));

String loginVoToJson(LoginVo data) => json.encode(data.toJson());

class LoginVo {
  LoginVo({
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

  factory LoginVo.fromJson(Map<String, dynamic> json) => LoginVo(
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
