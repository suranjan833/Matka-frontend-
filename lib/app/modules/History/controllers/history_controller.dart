import 'package:get/get.dart';

class HistoryController extends GetxController {
  final RxList<Map<String, dynamic>> historyList = <Map<String, dynamic>>[
    {
      "game": "SITA MORNING",
      "type": "Single Digit",
      "value": "7",
      "amount": 500,
      "profit": 4500,
      "status": "Won",
      "date": "2024-12-15",
      "time": "10:30 AM",
    },
    {
      "game": "STAR TARA MORNING",
      "type": "Jodi Digit",
      "value": "47",
      "amount": 200,
      "profit": -200,
      "status": "Lost",
      "date": "2024-12-15",
      "time": "11:00 AM",
    },
    {
      "game": "ANDHRA MORNING",
      "type": "Single Pana",
      "value": "228",
      "amount": 300,
      "profit": 5400,
      "status": "Won",
      "date": "2024-12-14",
      "time": "11:25 AM",
    },
    {
      "game": "SRIDEVI",
      "type": "Jodi Digit",
      "value": "89",
      "amount": 150,
      "profit": -150,
      "status": "Lost",
      "date": "2024-12-14",
      "time": "12:30 PM",
    },
    {
      "game": "KALYAN",
      "type": "Single Digit",
      "value": "3",
      "amount": 1000,
      "profit": 9000,
      "status": "Won",
      "date": "2024-12-13",
      "time": "6:00 PM",
    },
    {
      "game": "MILAN DAY",
      "type": "Double Pana",
      "value": "567",
      "amount": 250,
      "profit": -250,
      "status": "Lost",
      "date": "2024-12-13",
      "time": "3:15 PM",
    },
  ].obs;

  RxDouble totalInvested = 2400.0.obs;
  RxDouble totalProfit = 18300.0.obs;
}
