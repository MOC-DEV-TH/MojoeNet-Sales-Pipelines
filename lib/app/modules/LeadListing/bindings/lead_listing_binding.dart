import 'package:get/get.dart';

import '../controllers/lead_listing_controller.dart';

class LeadListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadListingController>(
      () => LeadListingController(),
    );
  }
}
