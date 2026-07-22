import 'package:get/get.dart';
import '../controllers/manual_deposit_controller.dart';

class ManualDepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManualDepositController>(() => ManualDepositController());
  }
}
