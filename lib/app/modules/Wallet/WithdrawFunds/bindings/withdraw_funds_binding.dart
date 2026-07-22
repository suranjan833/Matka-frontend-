import 'package:get/get.dart';
import '../controllers/withdraw_funds_controller.dart';

class WithdrawFundsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawFundsController>(() => WithdrawFundsController());
  }
}
