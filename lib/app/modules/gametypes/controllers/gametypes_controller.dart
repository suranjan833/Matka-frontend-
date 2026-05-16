/// gametypes_controller.dart
library;

import 'package:get/get.dart';

class GameTypesController extends GetxController {
  /// 🔥 Fixed Game Types
  final List<Map<String, dynamic>> gameTypes = [
    {"name": "Single", "code": "SINGLE", "digits": 1},
    {"name": "Jodi", "code": "JODI", "digits": 2},
    {"name": "Single Patti", "code": "SP", "digits": 3},
    {"name": "Double Patti", "code": "DP", "digits": 3},
    {"name": "Triple Patti", "code": "TP", "digits": 3},
    // {"name": "Half Sangam", "code": "HS", "digits": 4},
    // {"name": "Full Sangam", "code": "FS", "digits": 5},
    {"name": "Red Bracket", "code": "RB", "digits": 2},
  ];

  late Map<String, dynamic> bazaar;

  @override
  void onInit() {
    super.onInit();

    /// 🔥 Bazaar Data from previous screen
    bazaar = Get.arguments ?? {};
  }
}
