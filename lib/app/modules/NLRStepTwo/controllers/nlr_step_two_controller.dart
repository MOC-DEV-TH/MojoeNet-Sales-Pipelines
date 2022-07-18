import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NLRStepTwoController extends GetxController {

  var isSelected = -1;
  final count = 0.obs;
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

  void updateSelectedItem(int value){
    isSelected = value;
    update();
  }

  void navigateToSME(){
    Get.offNamed(Routes.SME);
  }

  void onPressContinue(){
    Get.offNamed(Routes.NLR_STEP_THREE);
  }

  void onPressBack(){
    Get.offNamed(Routes.NLR_STEP_ONE);
  }

}


