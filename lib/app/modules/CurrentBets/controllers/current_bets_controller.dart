import 'package:get/get.dart';

class CurrentBetsController extends GetxController {
  final RxList<Map<String, dynamic>> currentBets = <Map<String, dynamic>>[
    {
      'game': 'SITA MORNING',
      'type': 'Single Digit',
      'number': '7',
      'amount': 500,
      'status': 'Active',
      'time': '10:30 AM',
    },
    {
      'game': 'STAR TARA MORNING',
      'type': 'Jodi Digit',
      'number': '47',
      'amount': 200,
      'status': 'Active',
      'time': '11:00 AM',
    },
    {
      'game': 'ANDHRA MORNING',
      'type': 'Single Pana',
      'number': '228',
      'amount': 300,
      'status': 'Active',
      'time': '11:25 AM',
    },
    {
      'game': 'SRIDEVI',
      'type': 'Double Pana',
      'number': '118',
      'amount': 150,
      'status': 'Active',
      'time': '12:30 PM',
    },
    {
      'game': 'KALYAN',
      'type': 'Single Digit',
      'number': '3',
      'amount': 1000,
      'status': 'Active',
      'time': '6:00 PM',
    },
  ].obs;

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    currentBets.refresh();
  }
}
