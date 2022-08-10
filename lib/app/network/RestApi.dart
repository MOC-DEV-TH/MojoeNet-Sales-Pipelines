import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sales_pipeline/app/models/ActivityOverviewVO.dart';
import 'package:sales_pipeline/app/models/business_detail_vo.dart';
import 'package:sales_pipeline/app/models/contracted_detail_vo.dart';
import 'package:sales_pipeline/app/models/contracted_lead_vo.dart';
import 'package:sales_pipeline/app/models/leadVO.dart';
import 'package:sales_pipeline/app/models/loginVO.dart';
import 'package:sales_pipeline/app/models/network_result_vo.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';

class RestApi {
  static final String securityKey = 'moJoENEt2021sECuriTYkEy';
  static var client = http.Client();
  static var dataStorage = GetStorage();

  static Future<LoginVO> login(Map<String, String> params) async {
    debugPrint(params.toString());
    var response = await client.post(
      Uri.parse(LOGIN_URL),
      body: json.encode(params),
      headers: {
        'content-type': 'application/json',
        "security_key": securityKey
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return LoginVO.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }

  static Future<ActivityOverviewVO> fetchActivityOverview(
      String token, String uid) async {
    var response = await client.get(
      Uri.parse(GET_ACTIVITY_OVERVIEW_BY_UID_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return activityOverviewVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get activity overview lists');
    }
  }

  static Future<LeadVO> fetchLeadList(String token, String uid) async {
    var response = await client.get(
      Uri.parse(GET_LEAD_LIST_BY_UID_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return leadVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get lead list');
    }
  }

  static Future<LeadVO> fetchLeadListByFilterName(
      String token, String uid, String filterParamName) async {
    var response = await client.get(
      filterParamName == ''
          ? Uri.parse(GET_LEAD_LIST_BY_UID_URL +
              UID_PARAM +
              uid +
              APP_VERSION +
              app_version)
          : Uri.parse(GET_LEAD_LIST_BY_UID_URL +
              UID_PARAM +
              uid +
              APP_VERSION +
              app_version +
              filterParamName),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return leadVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get lead list by filter name');
    }
  }

  static void fetchAllDDlData() async {
    var response = await client.get(
      Uri.parse(GET_ALL_DDL_DATA_URL),
      headers: {
        'content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      dataStorage.write(ALL_DDL_DATA, json.encode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to get lead list');
    }
  }

  static Future<BusinessDetailVO> fetchActivityBusinessDetailById(
      String token, String uid, String leadID) async {
    var response = await client.get(
      Uri.parse(GET_ACTIVITY_BUSINESS_DETAIL_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version +
          LEAD_ID +
          leadID),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return businessDetailVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get business detail');
    }
  }

  static Future<NetworkResultVo> postLeadFormData(
      Map<dynamic, dynamic> params, String token) async {
    debugPrint(params.toString());
    var response = await client.post(
      Uri.parse(POST_LEAD_FORM_DATA_URL),
      body: json.encode(params),
      headers: {'content-type': 'application/json', 'token': token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return networkResultVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to post lead data');
    }
  }

  static Future<ContractedLeadVo> fetchContractedLeadList(
      String token, String uid) async {
    var response = await client.get(
      Uri.parse(GET_CONTRACTED_LEAD_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return contractedLeadVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get contracted lead list');
    }
  }

  static Future<ContractedLeadVo> fetchContractedLeadListByFilterName(
      String token, String uid, String filterName) async {
    var response = await client.get(
      filterName=='' ?
      Uri.parse(GET_CONTRACTED_LEAD_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version
          ) :
      Uri.parse(GET_CONTRACTED_LEAD_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version +
          filterName)
      ,
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return contractedLeadVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get contracted lead list');
    }
  }

  static Future<ContractedDetailVo> fetchContractedDetailById(
      String token, String uid, String leadID) async {
    var response = await client.get(
      Uri.parse(GET_CONTRACTED_DETAIL_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version +
          LEAD_ID +
          leadID),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return contractedDetailVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get contracted detail');
    }
  }

  static Future<NetworkResultVo> postContractedDetail(
      Map<dynamic, dynamic> params, String token) async {
    debugPrint(params.toString());
    var response = await client.post(
      Uri.parse(POST_CONTRACTED_DETAIL),
      body: json.encode(params),
      headers: {'content-type': 'application/json', 'token': token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return networkResultVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to post contracted detail data');
    }
  }

}
