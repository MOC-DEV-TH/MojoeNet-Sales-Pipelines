import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../models/contracted_detail_vo.dart';
import '../../../network/RestApi.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';

class WebViewController extends GetxController {
  final dataStorage = GetStorage();
  @override
  void onInit() {
    //if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  void onPressBack() {
    Get.back();
  }


}
