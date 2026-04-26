import 'package:get/get.dart';
import 'package:matka/app/config/app_config.dart';
import '../../../data/my_dio.dart';

class HomeController extends GetxController {
  var isProfileLoading = false.obs;
  var isWalletLoading = false.obs;

  var profileData = {}.obs;
  var wallet = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getWallet(); // ✅ call it
  }

  /// ============================
  /// PROFILE API
  /// ============================
  Future<void> getProfile() async {
    try {
      isProfileLoading.value = true;

      final response = await dioPost(
        endUrl: "get_profile.php",
        data: {"user_id": getBox.read(USER_ID)},
      );

      if (response.statusCode == 200) {
        profileData.value = response.data['data'] ?? response.data;
      } else {
        Get.snackbar("Error", "Profile load failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isProfileLoading.value = false;
    }
  }

  Future<void> getWallet() async {
    try {
      isWalletLoading.value = true;

      final response = await dioPost(
        endUrl: "get_wallet.php",
        data: {"user_id": getBox.read(USER_ID)},
      );

      if (response.statusCode == 200) {
        wallet.value = response.data['data'] ?? response.data;
      } else {
        Get.snackbar("Error", "Wallet load failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isWalletLoading.value = false;
    }
  }
}
