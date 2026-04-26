import 'package:get/get.dart';
import '../../../data/my_dio.dart';

class BazaarController extends GetxController {
  var isLoading = false.obs;
  var bazaarList = <Map<String, dynamic>>[].obs;

  int categoryId = 0;
  String categoryName = "";

  @override
  void onInit() {
    super.onInit();

    _initArgs();
    getBazaar();
  }

  /// 🔥 SAFE ARGUMENT HANDLING
  void _initArgs() {
    try {
      final args = Get.arguments;

      if (args is Map) {
        categoryId = int.tryParse(args['category_id']?.toString() ?? "0") ?? 0;

        categoryName = args['category_name']?.toString() ?? "";
      } else {
        /// 🔥 fallback
        categoryId = 0;
        categoryName = "";
      }
    } catch (e) {
      /// 🔥 crash prevent
      categoryId = 0;
      categoryName = "";
    }
  }

  /// 🔥 API CALL
  Future<void> getBazaar() async {
    try {
      isLoading.value = true;

      final response = await dioPost(
        endUrl: "get_game_market.php",
        data: {"category_id": categoryId},
      );

      if (response.statusCode == 200) {
        bazaarList.value = List<Map<String, dynamic>>.from(
          response.data['data'] ?? [],
        );
      } else {
        Get.snackbar("Error", "Failed to load bazaar");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
