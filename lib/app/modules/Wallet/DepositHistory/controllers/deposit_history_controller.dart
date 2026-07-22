import 'package:get/get.dart';

class DepositHistoryController extends GetxController {
  final RxList<Map<String, dynamic>> deposits = <Map<String, dynamic>>[
    {'amount': 1000, 'method': 'UPI', 'status': 'Completed', 'date': '2024-12-15', 'time': '10:30 AM', 'txnId': 'TXN001'},
    {'amount': 500, 'method': 'Net Banking', 'status': 'Pending', 'date': '2024-12-14', 'time': '2:15 PM', 'txnId': 'TXN002'},
    {'amount': 2000, 'method': 'UPI', 'status': 'Completed', 'date': '2024-12-13', 'time': '11:00 AM', 'txnId': 'TXN003'},
    {'amount': 1500, 'method': 'Wallet Transfer', 'status': 'Failed', 'date': '2024-12-12', 'time': '4:45 PM', 'txnId': 'TXN004'},
    {'amount': 3000, 'method': 'Manual Transfer', 'status': 'Pending', 'date': '2024-12-11', 'time': '9:20 AM', 'txnId': 'TXN005'},
  ].obs;
}
