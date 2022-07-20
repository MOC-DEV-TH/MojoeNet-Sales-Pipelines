import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sales_pipeline/app/models/loginVO.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';

class RestApi  {
  static final String securityKey = 'moJoENEt2021sECuriTYkEy';
  static var client = http.Client();

  static Future<LoginVo> login(
      Map<String, String> params) async {
    debugPrint(params.toString());
    var response = await client.post(
      Uri.parse(POST_LOGIN_URL),
      body: json.encode(params),
      headers: {
        'content-type': 'application/json',
        "security_key": securityKey
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return LoginVo.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }

}