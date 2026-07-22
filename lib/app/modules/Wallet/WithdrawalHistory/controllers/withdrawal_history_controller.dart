import 'package:get/get.dart';

class WithdrawalHistoryController extends GetxController {
  final RxList<Map<String, dynamic>> withdrawals = <Map<String, dynamic>>[
    {'amount': 2000, 'method': 'Bank Transfer', 'status': 'Completed', 'date': '2024-12-14', 'time': '3:30 PM', 'bank': 'HDFC Bank • XXXX1234'},
    {'amount': 500, 'method': 'Bank Transfer', 'status': 'Pending', 'date': '2024-12-13', 'time': '11:20 AM', 'bank': 'HDFC Bank • XXXX1234'},
    {'amount': 1500, 'method': 'Bank Transfer', 'status': 'Completed', 'date': '2024-12-10', 'time': '5:00 PM', 'bank': 'HDFC Bank • XXXX1234'},
    {'amount': 1000, 'method': 'Bank Transfer', 'status': 'Failed', 'date': '2024-12-08', 'time': '2:15 PM', 'bank': 'HDFC Bank • XXXX1234'},
  ].obs;
}
