import 'package:get/get.dart';

class ResultsController extends GetxController {
  final RxList<Map<String, dynamic>> results = <Map<String, dynamic>>[
    {'game': 'SITA MORNING', 'open': '7', 'close': '4', 'date': '2024-12-15'},
    {'game': 'STAR TARA MORNING', 'open': '2', 'close': '8', 'date': '2024-12-15'},
    {'game': 'ANDHRA MORNING', 'open': '5', 'close': '1', 'date': '2024-12-15'},
    {'game': 'SRIDEVI', 'open': '3', 'close': '9', 'date': '2024-12-14'},
    {'game': 'KALYAN', 'open': '6', 'close': '2', 'date': '2024-12-14'},
    {'game': 'MILAN DAY', 'open': '8', 'close': '5', 'date': '2024-12-14'},
    {'game': 'SITA MORNING', 'open': '1', 'close': '7', 'date': '2024-12-13'},
    {'game': 'STAR TARA MORNING', 'open': '9', 'close': '3', 'date': '2024-12-13'},
  ].obs;
}
