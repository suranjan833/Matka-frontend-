import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankDetailsController extends GetxController {
  final accountHolderController = TextEditingController();
  final accountNumberController = TextEditingController();
  final confirmAccountController = TextEditingController();
  final ifscController = TextEditingController();
  final bankNameController = TextEditingController();
  final upiIdController = TextEditingController();

  final RxString errorMessage = ''.obs;

  bool validate() {
    if (accountHolderController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter account holder name';
      return false;
    }
    if (accountNumberController.text.trim().isEmpty || accountNumberController.text.trim().length < 9) {
      errorMessage.value = 'Please enter a valid account number';
      return false;
    }
    if (accountNumberController.text.trim() != confirmAccountController.text.trim()) {
      errorMessage.value = 'Account numbers do not match';
      return false;
    }
    if (ifscController.text.trim().isEmpty || ifscController.text.trim().length < 11) {
      errorMessage.value = 'Please enter a valid IFSC code';
      return false;
    }
    if (bankNameController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter bank name';
      return false;
    }
    return true;
  }

  void submitBankDetails() {
    if (!validate()) return;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded, color: Color(0xff22C55E), size: 56),
            SizedBox(height: 16),
            const Text('Bank Details Saved!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('${bankNameController.text.trim()} • XXXX${accountNumberController.text.trim().substring(accountNumberController.text.trim().length - 4)}',
              style: const TextStyle(fontSize: 14, color: Colors.grey)),
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
    accountHolderController.dispose();
    accountNumberController.dispose();
    confirmAccountController.dispose();
    ifscController.dispose();
    bankNameController.dispose();
    upiIdController.dispose();
    super.onClose();
  }
}
