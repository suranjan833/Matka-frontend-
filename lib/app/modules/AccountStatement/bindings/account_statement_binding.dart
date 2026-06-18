import 'package:get/get.dart';

import '../controllers/account_statement_controller.dart';

class AccountStatementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountStatementController>(
      () => AccountStatementController(),
    );
  }
}
