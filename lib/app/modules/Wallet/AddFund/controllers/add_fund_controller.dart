import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Config/app_config.dart';
import '../../../../data/my_dio.dart';

class AddFundController extends GetxController {
  final amountController = TextEditingController();
  final txnIdController = TextEditingController();
  final RxDouble amount = 0.0.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedImagePath = ''.obs;
  final RxBool isLoading = false.obs;

  // UPI details
  final String upiId = "matkaapp@upi";
  final String upiName = "MATKA GAMES";

  final List<double> quickAmounts = [100, 500, 1000, 2000, 5000];

  void onAmountChanged(String value) {
    errorMessage.value = '';
    amount.value = double.tryParse(value) ?? 0.0;
  }

  bool validate() {
    if (amount.value <= 0) {
      errorMessage.value = 'Please enter a valid amount';
      return false;
    }
    if (amount.value < 100) {
      errorMessage.value = 'Minimum deposit amount is ₹100';
      return false;
    }
    if (amount.value > 5000) {
      errorMessage.value = 'Maximum deposit amount is ₹5000';
      return false;
    }
    return true;
  }

  void showPaymentDialog() {
    if (!validate()) return;
    selectedImagePath.value = '';
    txnIdController.clear();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.check_circle_outline, color: const Color(0xff22C55E), size: 22),
                  SizedBox(width: 8),
                  Text('Confirm Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close_rounded, color: Colors.grey.shade500, size: 22),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text('₹${amount.value.toStringAsFixed(0)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xff1673E6))),
              SizedBox(height: 4),
              Text('via UPI', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
              SizedBox(height: 20),

              // Upload screenshot
              Text('Upload Payment Screenshot', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
              SizedBox(height: 8),
              Obx(() {
                if (selectedImagePath.value.isNotEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xff22C55E).withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xff22C55E).withValues(alpha: .3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_rounded, color: const Color(0xff22C55E), size: 24),
                        SizedBox(width: 10),
                        Expanded(child: Text('Screenshot uploaded', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xff22C55E)))),
                        GestureDetector(
                          onTap: () => selectedImagePath.value = '',
                          child: Icon(Icons.close_rounded, color: Colors.grey.shade500, size: 20),
                        ),
                      ],
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () => selectedImagePath.value = 'selected',
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F7FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.cloud_upload_outlined, color: Colors.grey.shade400, size: 36),
                        SizedBox(height: 6),
                        Text('Tap to upload screenshot', style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                        SizedBox(height: 4),
                        Text('PNG, JPG (max 5MB)', style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 16),

              // Transaction ID
              Text('Transaction ID / UTR', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
              SizedBox(height: 6),
              TextField(
                controller: txnIdController,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'e.g. TXN1234567890',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                  filled: true, fillColor: const Color(0xffF5F7FA),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: const Color(0xff1673E6), width: 1.5)),
                ),
              ),
              SizedBox(height: 20),

              // Confirm button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => _confirmPayment(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1673E6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text('Confirm & Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmPayment() async {
    if (selectedImagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please upload a payment screenshot', snackPosition: SnackPosition.TOP);
      return;
    }
    if (txnIdController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter the transaction ID', snackPosition: SnackPosition.TOP);
      return;
    }

    isLoading.value = true;
    Get.back(); // close payment dialog

    try {
      final userId = getBox.read(USER_ID) ?? '0';

      final response = await dioPost(
        data: {
          "user_id": int.tryParse(userId.toString()) ?? 0,
          "amount": amount.value,
          "transaction_id": txnIdController.text.trim(),
          "type": "Manual",
          "image": selectedImagePath.value,
        },
        endUrl: "add_money.php",
        isFile: true,
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
                const Text('Payment Request Sent!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('₹${amount.value.toStringAsFixed(0)} via UPI', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 8),
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
        amountController.clear();
        amount.value = 0.0;
      } else {
        Get.snackbar('Error', data['message'] ?? 'Deposit failed', snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong', snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    amountController.dispose();
    txnIdController.dispose();
    super.onClose();
  }
}
