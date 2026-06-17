import 'package:get/get.dart';

import '../controllers/sign_up_view_controller.dart';

class SignUpViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
