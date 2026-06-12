library;

import 'package:get/get.dart';

class GameTypesController extends GetxController {
  final List<Map<String, dynamic>> gameTypes = [
    {
      "name": "Single Digit",
      "code": "SINGLE",
      "icon": "🎯",
      "description": "0-9",
    },
    {
      "name": "Single Bulk",
      "code": "SINGLE_BULK",
      "icon": "🎯",
      "description": "Bulk Entry",
    },
    {
      "name": "Jodi Digit",
      "code": "JODI",
      "icon": "🎲",
      "description": "00-99",
    },
    {
      "name": "Jodi Bulk",
      "code": "JODI_BULK",
      "icon": "🎲",
      "description": "Bulk Entry",
    },
    {
      "name": "Single Pana",
      "code": "SP",
      "icon": "🔢",
      "description": "123, 137",
    },
    {
      "name": "Single Pana Bulk",
      "code": "SP_BULK",
      "icon": "🔢",
      "description": "Bulk Entry",
    },
    {
      "name": "Double Pana",
      "code": "DP",
      "icon": "🔁",
      "description": "112, 336",
    },
    {
      "name": "Double Pana Bulk",
      "code": "DP_BULK",
      "icon": "🔁",
      "description": "Bulk Entry",
    },
    {
      "name": "Triple Pana",
      "code": "TP",
      "icon": "💎",
      "description": "111, 222",
    },
    {
      "name": "SP Motor",
      "code": "SPM",
      "icon": "🚀",
      "description": "Min 4 Digit",
    },
    {
      "name": "DP Motor",
      "code": "DPM",
      "icon": "🔥",
      "description": "Min 4 Digit",
    },
    {
      "name": "Group Jodi",
      "code": "GROUP_JODI",
      "icon": "👥",
      "description": "27 → 27,72,22,77",
    },
    {
      "name": "Red Bracket",
      "code": "RB",
      "icon": "🟥",
      "description": "Special Jodi",
    },
    {
      "name": "Half Sangam",
      "code": "HS",
      "icon": "⚡",
      "description": "Pana + Ank",
    },
    {
      "name": "Full Sangam",
      "code": "FS",
      "icon": "👑",
      "description": "Pana + Pana",
    },
  ];

  late Map<String, dynamic> bazaar;

  @override
  void onInit() {
    super.onInit();
    bazaar = Get.arguments ?? {};
  }
}
