import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/models/dropDownVO.dart';
import 'package:sales_pipeline/app/models/leadVO.dart';

import '../../../network/RestApi.dart';
import '../../../utils/app_constants.dart';

class LeadListingController extends GetxController {
  var businessNameTextController = TextEditingController();
  var contactNoTextController = TextEditingController();
  var leadDetail = <Detail>[].obs;
  final count = 0.obs;
  var isLoading = false.obs;
  var isFooterLoading = false.obs;
  final dataStorage = GetStorage();
  dynamic saleStatusData;

  @override
  void onInit() {
    super.onInit();
    saleStatusData =
        dropDownVoFromJson(json.decode(dataStorage.read(ALL_DDL_DATA).toString()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void fetchLeadList() {
    isLoading(true);
    RestApi.fetchLeadList(dataStorage.read(TOKEN), dataStorage.read(UID))
        .then((value) => {
              if (value.status == 'Success')
                {
                  debugPrint("LeadList ${value.details}"),
                  leadDetail.value = value.details!,
                  isLoading(false)
                }
              else
                {isLoading(false)}
            });
  }

  void fetchLeadListByFilterName(String filterName) {
    isFooterLoading(true);
    RestApi.fetchLeadListByFilterName(dataStorage.read(TOKEN), dataStorage.read(UID),filterName)
        .then((value) => {
      if (value.status == 'Success')
        {
          debugPrint("LeadFilterList ${value.details}"),
          leadDetail.value = value.details!,
          isFooterLoading(false)
        }
      else
        {isFooterLoading(false)}
    });
  }

}
