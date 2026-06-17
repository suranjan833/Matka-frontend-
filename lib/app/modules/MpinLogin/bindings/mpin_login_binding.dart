import 'package:get/get.dart';

import '../controllers/mpin_login_controller.dart';

class MpinLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MpinLoginController>(
      () => MpinLoginController(),
    );
  }
}
