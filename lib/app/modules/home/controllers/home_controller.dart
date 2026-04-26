import 'package:get/get.dart';
import 'package:matka/app/config/app_config.dart';
import '../../../data/my_dio.dart';

class HomeController extends GetxController {
  /// 🔹 Loading
  var isProfileLoading = false.obs;
  var isWalletLoading = false.obs;
  var isCategoryLoading = false.obs;

  /// 🔹 Data (STRONG TYPES)
  var profileData = <String, dynamic>{}.obs;
  var wallet = <String, dynamic>{}.obs;
  var categories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getWallet();
    getCategories();
  }

  /// 🔹 PROFILE
  Future<void> getProfile() async {
    try {
      isProfileLoading.value = true;

      final response = await dioPost(
        endUrl: "get_profile.php",
        data: {"user_id": getBox.read(USER_ID)},
      );

      if (response.statusCode == 200) {
        profileData.value = Map<String, dynamic>.from(
          response.data['data'] ?? {},
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isProfileLoading.value = false;
    }
  }

  /// 🔹 WALLET
  Future<void> getWallet() async {
    try {
      isWalletLoading.value = true;

      final response = await dioPost(
        endUrl: "get_wallet.php",
        data: {"user_id": getBox.read(USER_ID)},
      );

      if (response.statusCode == 200) {
        wallet.value = Map<String, dynamic>.from(response.data['data'] ?? {});
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isWalletLoading.value = false;
    }
  }

  /// 🔹 CATEGORY
  Future<void> getCategories() async {
    try {
      isCategoryLoading.value = true;

      final response = await dioGet("get_game_categories.php");

      if (response.statusCode == 200) {
        categories.value = List<Map<String, dynamic>>.from(
          response.data['data'] ?? [],
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isCategoryLoading.value = false;
    }
  }
}
