import 'package:get/get.dart';

import '../controllers/n_l_r_step_seven_controller.dart';

class NLRStepSevenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NLRStepSevenController>(
      () => NLRStepSevenController(),
    );
  }
}
