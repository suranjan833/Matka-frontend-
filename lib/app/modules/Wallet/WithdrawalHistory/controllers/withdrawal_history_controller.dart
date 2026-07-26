import 'package:get/get.dart';

import '../../../../Config/app_config.dart';
import '../../../../data/my_dio.dart';
import '../../models/transaction_model.dart';

class WithdrawalHistoryController extends GetxController {
  final RxList<Map<String, dynamic>> withdrawals = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWithdrawalHistory();
  }

  Future<void> fetchWithdrawalHistory() async {
    isLoading.value = true;

    try {
      final userId = getBox.read(USER_ID) ?? '0';
      final response = await dioPost(
        data: {"user_id": int.tryParse(userId.toString()) ?? 0},
        endUrl: "wallet_history.php",
      );

      final data = response.data;
      if (data['status'] == 200 && data['data'] != null) {
        final List<dynamic> transactions = data['data'];
        withdrawals.value = transactions
          .where((t) => (t as Map<String, dynamic>)['type'] == 'withdrawal')
          .map((t) => TransactionModel.fromJson(t as Map<String, dynamic>).toWithdrawalViewModel())
          .toList();
      }
    } catch (e) {
      // Keep empty list on error
    } finally {
      isLoading.value = false;
    }
  }
}
