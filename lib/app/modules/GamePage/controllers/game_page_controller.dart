import 'package:get/get.dart';
import '../../BetType/bet_type.dart';

class GamePageController extends GetxController {
  late Map<String, dynamic> market;

  final RxList<BetTypeCategory> betTypes = BetTypeCategory.values.toList().obs;

  @override
  void onInit() {
    super.onInit();
    market = Get.arguments as Map<String, dynamic>;
  }
}
