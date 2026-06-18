import 'package:get/get.dart';
import '../modules/BetType/bet_type.dart';

class BetSlipItem {
  final String marketName;
  final BetTypeCategory betType;
  final String numbers;
  final double amount;

  BetSlipItem({
    required this.marketName,
    required this.betType,
    required this.numbers,
    required this.amount,
  });

  String get betTypeName => betType.displayName;
}

class BetSlipService extends GetxController {
  final RxList<BetSlipItem> items = <BetSlipItem>[].obs;

  double get totalAmount => items.fold(0, (sum, item) => sum + item.amount);
  int get itemCount => items.length;

  void addItem(BetSlipItem item) {
    items.add(item);
  }

  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
  }

  void clear() {
    items.clear();
  }
}
