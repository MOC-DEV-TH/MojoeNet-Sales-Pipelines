import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/routes/app_pages.dart';

import '../../../network/RestApi.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';

class LoginController extends GetxController {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var allDropDownData;
  final count = 0.obs;
  var isLoading = false.obs;
  final writeData = GetStorage();

  static LoginController get to => Get.find();

  @override
  void onInit() {
    firstTimeFetchAllDropDownDataFromNetwork();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void onPressLogin() {
    debugPrint('click');
    if (userNameController.text != '' || passwordController.text != '') {
      isLoading(true);
      Map<String, String> map = {
        'user_id': userNameController.value.text,
        'password': passwordController.value.text
      };

      debugPrint('call api');
      RestApi.login(map).then((value) => {
            Future.delayed(Duration.zero, () {
              if (value.status == 'Success') {
                writeData.write(TOKEN, value.token);
                writeData.write(UID, value.uid);
                isLoading(false);
                Get.offNamed(Routes.TASK_SELECTION);
              } else {
                isLoading(false);
                AppUtils.showErrorSnackBar("Fail", value.description ?? '');
              }
            })
          });
    } else {
      isLoading(false);
    }
  }

  void firstTimeFetchAllDropDownDataFromNetwork() {
    RestApi.fetchAllDDlData();
  }
}
