import 'package:get/get.dart';

class HomeController extends GetxController {
  RxDouble walletBalance = 0.0.obs;

  final RxList<Map<String, dynamic>> markets = <Map<String, dynamic>>[
    {
      "name": "SITA MORNING",
      "result": "579-12-228",
      "status": "Betting Is Closed For Today",
      "openTime": "9:40 AM",
      "closeTime": "10:40 AM",
    },
    {
      "name": "STAR TARA MORNING",
      "result": "590-47-359",
      "status": "Betting Is Closed For Today",
      "openTime": "10:05 AM",
      "closeTime": "11:05 AM",
    },
    {
      "name": "ANDHRA MORNING",
      "result": "290-18-116",
      "status": "Betting Is Closed For Today",
      "openTime": "10:35 AM",
      "closeTime": "11:35 AM",
    },
    {
      "name": "SRIDEVI",
      "result": "145-67-890",
      "status": "Betting Is Closed For Today",
      "openTime": "11:45 AM",
      "closeTime": "12:45 PM",
    },
  ].obs;
}
