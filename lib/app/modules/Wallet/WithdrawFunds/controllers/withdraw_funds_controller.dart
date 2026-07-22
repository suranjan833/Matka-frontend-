import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawFundsController extends GetxController {
  final amountController = TextEditingController();
  final RxDouble amount = 0.0.obs;
  final RxString errorMessage = ''.obs;

  final List<Map<String, dynamic>> savedBanks = [
    {'name': 'HDFC Bank', 'account': 'XXXX1234', 'ifsc': 'HDFC0001234', 'holder': 'John Doe'},
  ];

  final RxInt selectedBankIndex = 0.obs;

  void selectBank(int index) {
    selectedBankIndex.value = index;
    errorMessage.value = '';
  }

  void onAmountChanged(String value) {
    errorMessage.value = '';
    amount.value = double.tryParse(value) ?? 0.0;
  }

  bool validate() {
    if (amount.value <= 0) {
      errorMessage.value = 'Please enter a valid amount';
      return false;
    }
    if (amount.value < 500) {
      errorMessage.value = 'Minimum withdrawal amount is ₹500';
      return false;
    }
    return true;
  }

  void submitWithdraw() {
    if (!validate()) return;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded, color: Color(0xff22C55E), size: 56),
            SizedBox(height: 16),
            const Text('Withdrawal Request Submitted!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('₹${amount.value.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            const Text('Amount will be credited within 24 hours.', style: TextStyle(fontSize: 13, color: Colors.grey)),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () { Get.back(); Get.back(); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1673E6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Done', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
