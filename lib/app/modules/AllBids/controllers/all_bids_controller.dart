import 'package:get/get.dart';

class AllBidsController extends GetxController {
  final RxDouble walletBalance = 100.0.obs;

  final RxList<Map<String, dynamic>> menuList = <Map<String, dynamic>>[
    {"title": "Bid History"},
    {"title": "Fund Request History"},
    {"title": "Approved Credit History"},
    {"title": "Approved Debit History"},
  ].obs;

  void onMenuTap(int index) {
    switch (index) {
      case 0:
        // Get.to(() => BidHistoryView());
        break;

      case 1:
        // Get.to(() => FundRequestHistoryView());
        break;

      case 2:
        // Get.to(() => ApprovedCreditHistoryView());
        break;

      case 3:
        // Get.to(() => ApprovedDebitHistoryView());
        break;
    }
  }
}
