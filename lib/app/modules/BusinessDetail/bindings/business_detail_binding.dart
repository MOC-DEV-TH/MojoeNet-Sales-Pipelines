import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/BusinessDetail/controllers/business_detail_controller.dart';


class BusinessDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessDetailController>(
      () => BusinessDetailController(),
    );
  }
}
