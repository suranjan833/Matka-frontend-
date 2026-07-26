import 'package:get/get.dart';

import '../controllers/set_mpin_controller.dart';

class SetMpinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetMpinController>(
      () => SetMpinController(),
    );
  }
}
