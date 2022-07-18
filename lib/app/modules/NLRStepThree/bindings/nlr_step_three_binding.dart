import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/NLRStepThree/controllers/nlr_step_three_controller.dart';


class NLRStepThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NLRStepThreeController>(
      () => NLRStepThreeController(),
    );
  }
}
