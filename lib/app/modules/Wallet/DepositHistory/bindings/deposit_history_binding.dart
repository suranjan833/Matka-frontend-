import 'package:get/get.dart';
import '../controllers/deposit_history_controller.dart';

class DepositHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DepositHistoryController>(() => DepositHistoryController());
  }
}
