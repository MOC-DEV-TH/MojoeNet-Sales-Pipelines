import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/ForgotPassword/controllers/forgot_password_controller.dart';


class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
  }
}
