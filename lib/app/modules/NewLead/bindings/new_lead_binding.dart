import 'package:get/get.dart';

import '../controllers/new_lead_controller.dart';

class NewLeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewLeadController>(
      () => NewLeadController(),
    );
  }
}
