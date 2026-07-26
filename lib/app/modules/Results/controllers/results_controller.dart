import 'package:get/get.dart';

import '../../../data/my_dio.dart';
import '../models/result_model.dart';

class ResultsController extends GetxController {
  final RxList<Map<String, dynamic>> results = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchResults();
  }

  Future<void> fetchResults() async {
    isLoading.value = true;

    try {
      final response = await dioPost(
        data: {"market_id": 0},
        endUrl: "get_published_results.php",
      );

      final data = response.data;
      if (data['status'] == 1 && data['data'] != null) {
        final List<dynamic> resultList = data['data'];
        results.value = resultList.map((r) {
          return ResultModel.fromJson(r as Map<String, dynamic>).toViewModel();
        }).toList();
      }
    } catch (e) {
      // Keep empty list on error
    } finally {
      isLoading.value = false;
    }
  }
}
