import 'package:get/get.dart';

import '../controllers/place_bet_controller.dart';

class PlaceBetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceBetController>(
      () => PlaceBetController(),
    );
  }
}
