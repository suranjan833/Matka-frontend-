import 'package:get/get.dart';

import '../../../Config/app_config.dart';
import '../../../data/my_dio.dart';

class AccountStatementController extends GetxController {
  final RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;
  final RxDouble totalDeposits = 0.0.obs;
  final RxDouble totalWithdrawals = 0.0.obs;
  final RxDouble totalBets = 0.0.obs;
  final RxDouble totalWinnings = 0.0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAccountStatement();
  }

  Future<void> fetchAccountStatement() async {
    isLoading.value = true;

    try {
      final userId = getBox.read(USER_ID) ?? '0';
      final response = await dioPost(
        data: {"user_id": int.tryParse(userId.toString()) ?? 0},
        endUrl: "wallet_history.php",
      );

      final data = response.data;
      if (data['status'] == 200 && data['data'] != null) {
        final List<dynamic> txnList = data['data'];
        transactions.value = txnList.map((t) => t as Map<String, dynamic>).toList();

        // Calculate summary
        double deposits = 0;
        double withdrawals = 0;
        double bets = 0;
        double winnings = 0;

        for (final t in transactions) {
          final type = t['type'] ?? '';
          final amount = (t['amount'] ?? 0).toDouble();
          final status = t['status'] ?? 0;

          if (type == 'deposit' && status == 1) {
            deposits += amount;
          } else if (type == 'withdrawal' && status == 1) {
            withdrawals += amount;
          } else if (type == 'bet') {
            bets += amount;
            if (status == 1) winnings += amount * 9;
          }
        }

        totalDeposits.value = deposits;
        totalWithdrawals.value = withdrawals;
        totalBets.value = bets;
        totalWinnings.value = winnings;
      }
    } catch (e) {
      // Keep empty state
    } finally {
      isLoading.value = false;
    }
  }
}
