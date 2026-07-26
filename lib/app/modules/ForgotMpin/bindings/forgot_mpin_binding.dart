import 'package:get/get.dart';

import '../controllers/forgot_mpin_controller.dart';

class ForgotMpinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotMpinController>(
      () => ForgotMpinController(),
    );
  }
}
