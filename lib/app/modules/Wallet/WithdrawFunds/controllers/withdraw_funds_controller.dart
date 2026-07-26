import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Config/app_config.dart';
import '../../../../data/my_dio.dart';

class WithdrawFundsController extends GetxController {
  final amountController = TextEditingController();
  final RxDouble amount = 0.0.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;

  final RxList<Map<String, dynamic>> savedBanks = <Map<String, dynamic>>[
    {'name': 'HDFC Bank', 'account': 'XXXX1234', 'ifsc': 'HDFC0001234', 'holder': 'John Doe', 'id': 1},
  ].obs;

  final RxInt selectedBankIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedBanks();
  }

  Future<void> fetchSavedBanks() async {
    try {
      final response = await dioGet("saved-banks");
      final data = response.data;
      if (data['status'] == true && data['data'] != null) {
        final List<dynamic> banks = data['data'];
        savedBanks.value = banks.map((b) {
          final bank = b as Map<String, dynamic>;
          return {
            'id': bank['id'],
            'name': bank['bank_name'],
            'account': bank['account_number'],
            'ifsc': bank['ifsc'],
            'holder': bank['account_holder'],
            'is_default': bank['is_default'] ?? false,
          };
        }).toList();
      }
    } catch (e) {
      // Keep hardcoded banks on error
    }
  }

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

  Future<void> submitWithdraw() async {
    if (!validate()) return;

    isLoading.value = true;

    try {
      final userId = getBox.read(USER_ID) ?? '0';
      final selectedBank = savedBanks[selectedBankIndex.value];

      final response = await dioPost(
        data: {
          "user_id": int.tryParse(userId.toString()) ?? 0,
          "amount": amount.value,
          "method": "Bank Transfer",
          "account_holder": selectedBank['holder'],
          "bank_name": selectedBank['name'],
          "account_number": selectedBank['account'],
          "ifsc_code": selectedBank['ifsc'],
        },
        endUrl: "withdraw_request.php",
      );

      final data = response.data;
      if (data['status'] == 200) {
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
        amountController.clear();
        amount.value = 0.0;
      } else {
        Get.snackbar('Error', data['message'] ?? 'Withdrawal failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
