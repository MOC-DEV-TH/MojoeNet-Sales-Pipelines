import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/routes/app_pages.dart';

import '../../../network/RestApi.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final count = 0.obs;
  var isLoading = false.obs;
  final writeData = GetStorage();

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

  void onPressLogin() {
    debugPrint('click');
    if (emailController.text != '' || passwordController.text != '') {
      isLoading(true);
      Map<String, String> map = {
        'email': emailController.value.text,
        'password': passwordController.value.text
      };

      debugPrint('call api');
      RestApi.login(map).then((value) => {
            Future.delayed(Duration.zero, () {
              if (value.status == 'Success') {
                writeData.write(TOKEN, value.token);
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
}
