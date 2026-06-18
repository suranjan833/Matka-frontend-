import 'package:get/get.dart';
import '../controllers/bet_input_page_controller.dart';

class BetInputPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BetInputPageController>(
      () => BetInputPageController(),
    );
  }
}
