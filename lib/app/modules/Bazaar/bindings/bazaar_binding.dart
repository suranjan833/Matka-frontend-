import 'package:get/get.dart';

import '../controllers/bazaar_controller.dart';

class BazaarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BazaarController>(
      () => BazaarController(),
    );
  }
}
