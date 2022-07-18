import 'package:get/get.dart';

import '../controllers/nlr_step_two_controller.dart';

class NLRStepTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NLRStepTwoController>(
      () => NLRStepTwoController(),
    );
  }
}
