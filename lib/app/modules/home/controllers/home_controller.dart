import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Config/app_config.dart';
import '../../../data/my_dio.dart';
import '../models/market_model.dart';
import '../models/profile_model.dart';

class HomeController extends GetxController {
  RxDouble walletBalance = 0.0.obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;

  final RxList<Map<String, dynamic>> markets = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchMarkets();
    fetchWalletBalance();
  }

  void loadUserData() {
    final box = GetStorage();
    userName.value = box.read(USER_NAME) ?? 'Player';
    userEmail.value = box.read(USER_EMAIL) ?? '';
  }

  Future<void> fetchMarkets() async {
    try {
      final response = await dioGet("get_game_market.php");
      final data = response.data;
      if (data['status'] == 1 && data['data'] != null) {
        final List<dynamic> marketList = data['data'];
        markets.value = marketList.map((m) {
          return MarketModel.fromJson(m as Map<String, dynamic>).toViewModel();
        }).toList();
      }
    } catch (e) {
      // Keep empty list on error
    }
  }

  Future<void> fetchWalletBalance() async {
    try {
      final userId = getBox.read(USER_ID) ?? '0';
      final response = await dioPost(
        data: {"user_id": int.tryParse(userId.toString()) ?? 0},
        endUrl: "get_wallet.php",
      );
      final data = response.data;
      if (data['status'] == 200 && data['data'] != null) {
        walletBalance.value = (data['data']['balance'] ?? 0).toDouble();
      }
    } catch (e) {
      // Keep current balance
    }
  }

  Future<void> fetchProfile() async {
    try {
      final userId = getBox.read(USER_ID) ?? '0';
      final response = await dioPost(
        data: {"user_id": int.tryParse(userId.toString()) ?? 0},
        endUrl: "get_profile.php",
      );
      final data = response.data;
      if (data['status'] == 200 && data['data'] != null) {
        final profile = ProfileModel.fromJson(data['data']);
        final box = GetStorage();
        box.write(USER_NAME, profile.name);
        box.write(USER_EMAIL, profile.email);
        userName.value = profile.name;
        userEmail.value = profile.email;
        walletBalance.value = profile.wallet;
      }
    } catch (e) {
      // Ignore errors
    }
  }

  Future<void> onRefresh() async {
    await Future.wait([
      fetchMarkets(),
      fetchWalletBalance(),
      fetchProfile(),
    ]);
  }
}
