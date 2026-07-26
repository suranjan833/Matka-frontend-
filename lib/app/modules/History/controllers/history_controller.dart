import 'package:get/get.dart';

import '../../../Config/app_config.dart';
import '../../../data/my_dio.dart';
import '../models/bet_history_model.dart';

class HistoryController extends GetxController {
  final RxList<Map<String, dynamic>> historyList = <Map<String, dynamic>>[].obs;
  final RxDouble totalInvested = 0.0.obs;
  final RxDouble totalProfit = 0.0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBetHistory();
  }

  Future<void> fetchBetHistory() async {
    isLoading.value = true;

    try {
      final userId = getBox.read(USER_ID) ?? '0';
      final response = await dioPost(
        data: {"user_id": int.tryParse(userId.toString()) ?? 0},
        endUrl: "get_bet_history.php",
      );

      final data = response.data;
      if (data['status'] == 200 && data['data'] != null) {
        final List<dynamic> bets = data['data'];
        historyList.value = bets.map((b) {
          return BetHistoryModel.fromJson(b as Map<String, dynamic>).toViewModel();
        }).toList();

        // Calculate summary
        double invested = 0;
        double profit = 0;
        for (final h in historyList) {
          invested += (h['amount'] as double?) ?? 0;
          profit += (h['profit'] as double?) ?? 0;
        }
        totalInvested.value = invested;
        totalProfit.value = profit;
      }
    } catch (e) {
      // Keep empty list on error
    } finally {
      isLoading.value = false;
    }
  }
}
