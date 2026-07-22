import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManualDepositController extends GetxController {
  final amountController = TextEditingController();
  final transactionIdController = TextEditingController();
  final RxDouble amount = 0.0.obs;
  final RxString selectedImagePath = ''.obs;
  final RxString errorMessage = ''.obs;

  void onAmountChanged(String value) {
    errorMessage.value = '';
    amount.value = double.tryParse(value) ?? 0.0;
  }

  Future<void> pickImage() async {
    // Simulate picking an image
    selectedImagePath.value = 'selected_image_path';
    errorMessage.value = '';
  }

  void removeImage() {
    selectedImagePath.value = '';
  }

  bool validate() {
    if (amount.value <= 0 || amount.value < 100) {
      errorMessage.value = 'Minimum deposit amount is ₹100';
      return false;
    }
    if (transactionIdController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter the transaction ID';
      return false;
    }
    if (selectedImagePath.value.isEmpty) {
      errorMessage.value = 'Please upload a payment screenshot';
      return false;
    }
    return true;
  }

  void submitDeposit() {
    if (!validate()) return;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded, color: Color(0xff22C55E), size: 56),
            SizedBox(height: 16),
            const Text('Deposit Request Submitted!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('₹${amount.value.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            const Text('Your deposit will be verified within 24 hours.', style: TextStyle(fontSize: 13, color: Colors.grey)),
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
    transactionIdController.dispose();
    super.onClose();
  }
}
