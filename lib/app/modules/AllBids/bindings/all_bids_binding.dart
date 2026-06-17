import 'package:get/get.dart';

import '../controllers/all_bids_controller.dart';

class AllBidsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllBidsController>(
      () => AllBidsController(),
    );
  }
}
