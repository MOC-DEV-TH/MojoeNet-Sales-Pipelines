import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/models/contracted_lead_vo.dart';

import '../../../network/RestApi.dart';
import '../../../utils/app_constants.dart';

class ContractedController extends GetxController {
  var businessNameTextController = TextEditingController();
  var contactNoTextController = TextEditingController();
  final count = 0.obs;
  final dataStorage = GetStorage();
  var isLoading = false.obs;
  var isFooterLoading = false.obs;
  final contractedLeadData = <Detail>[].obs;

  static ContractedController get to => Get.find();

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


  void fetchContractedLead() {
    isLoading(true);
    RestApi.fetchContractedLeadList(
        dataStorage.read(TOKEN), dataStorage.read(UID))
        .then((value) => {
      if (value.status == 'Success')
        {
          contractedLeadData.value = value.details!,
          isLoading(false)
        }
      else
        {isLoading(false)}
    });
  }
  void fetchContractedLeadByFilterName(String filterName) {
    isFooterLoading(true);
    RestApi.fetchContractedLeadListByFilterName(
        dataStorage.read(TOKEN), dataStorage.read(UID),filterName)
        .then((value) => {
      if (value.status == 'Success')
        {
          contractedLeadData.value = value.details!,
          isFooterLoading(false)
        }
      else
        {isFooterLoading(false)}
    });
  }
}
