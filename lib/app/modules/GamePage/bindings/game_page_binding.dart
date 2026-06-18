import 'package:get/get.dart';
import '../controllers/game_page_controller.dart';

class GamePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GamePageController>(
      () => GamePageController(),
    );
  }
}
