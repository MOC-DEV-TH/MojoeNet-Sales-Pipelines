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
  var estContractTextController = TextEditingController();
  var contactNoTextController = TextEditingController();
  var leadDetail = <Detail>[].obs;
  final count = 0.obs;
  var isLoading = false.obs;
  var isFooterLoading = false.obs;
  final dataStorage = GetStorage();
  dynamic saleStatusData;
  List<Detail> _defaultListCache = [];
  final hasEstDate = false.obs;

  static LeadListingController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    saleStatusData =
        dropDownVoFromJson(json.decode(dataStorage.read(ALL_DDL_DATA).toString()));
  }

  @override
  void onReady() {
    super.onReady();
    fetchLeadList();
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
                  _defaultListCache = leadDetail.toList(),
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

  String _toYmd(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  Future<void> pickEstContractDate({
    required BuildContext context,
    String paramKey = EST_CONTRACT_DATE_PARAM,
  }) async {
    DateTime initial = DateTime.now();
    final raw = estContractTextController.text.trim();
    if (raw.isNotEmpty) {
      final parsed = DateTime.tryParse(raw);
      if (parsed != null) initial = parsed;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked == null) return;

    final ymd = _toYmd(picked);
    estContractTextController.text = ymd;
    hasEstDate.value = true;

    fetchLeadListByFilterName(paramKey + ymd);
  }

  /// ✅ Clear date → restore previous/default list
  void clearEstContractDate() {
    estContractTextController.clear();
    hasEstDate.value = false;

    // if (_defaultListCache.isNotEmpty) {
    //   leadDetail.value = _defaultListCache;
    //   return;
    // }
    fetchLeadList();
  }

}
