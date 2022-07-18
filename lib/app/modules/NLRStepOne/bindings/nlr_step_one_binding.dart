import 'package:get/get.dart';

import '../controllers/nlr_step_one_controller.dart';

class NLRStepOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NLRStepOneController>(
      () => NLRStepOneController(),
    );
  }
}
