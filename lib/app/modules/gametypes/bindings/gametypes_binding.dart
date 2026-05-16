import 'package:get/get.dart';

import '../controllers/gametypes_controller.dart';

class GametypesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameTypesController>(() => GameTypesController());
  }
}
