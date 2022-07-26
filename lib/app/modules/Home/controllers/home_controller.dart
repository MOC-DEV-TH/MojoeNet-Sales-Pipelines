import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/models/ActivityOverviewVO.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';

import '../../../network/RestApi.dart';
import '../../../utils/app_utils.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  final activityOverviewDetailData = Details().obs;
  final readData = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void fetchActivityOverview(BuildContext context) {
      isLoading(true);
      RestApi.fetchActivityOverview(
          readData.read(TOKEN), readData.read(UID))
          .then((value) => {
        if (value.status == 'Success')
          {
            debugPrint("ActivityOverviewList ${value.details}"),
            activityOverviewDetailData.value = value.details!,
            isLoading(false)
          }
        else if (value.responseCode == '005')
          {
            isLoading(false),
            AppUtils.showSessionExpireDialog(
                'Fail', 'Session Expired', context)
          }
        else
          {isLoading(false)}
      });
  }
}
