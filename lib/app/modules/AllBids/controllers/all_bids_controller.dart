import 'package:get/get.dart';

import '../../CurrentBets/views/current_bets_view.dart';

class AllBidsController extends GetxController {
  final RxDouble walletBalance = 100.0.obs;

  final RxList<Map<String, dynamic>> menuList = <Map<String, dynamic>>[
    {"title": "Bid History"},
  ].obs;

  void onMenuTap(int index) {
    Get.to(() => const CurrentBetsView());
  }
}
