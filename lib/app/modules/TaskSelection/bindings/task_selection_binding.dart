import 'package:get/get.dart';

import '../controllers/task_selection_controller.dart';

class TaskSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskSelectionController>(
      () => TaskSelectionController(),
    );
  }
}
