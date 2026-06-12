import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_config.dart';
import '../../../data/my_dio.dart';

class WithdrawPageController extends GetxController {
  /// Controllers
  final amountController = TextEditingController();
  final nameController = TextEditingController();
  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final ifscController = TextEditingController();
  final upiController = TextEditingController();

  var isLoading = false.obs;
  var selectedAmount = 0.obs;
  var hasAmount = false.obs;
  var hasBankOrUpi = false.obs;

  /// 🔥 Quick Amount
  void setAmount(int amount) {
    selectedAmount.value = amount;
    amountController.text = amount.toString();
    hasAmount.value = true;
  }

  /// 🔥 Submit Withdraw
  Future<void> submitWithdraw() async {
    if (amountController.text.isEmpty) {
      Get.snackbar("Error", "Enter amount");
      return;
    }

    if (accountController.text.isEmpty && upiController.text.isEmpty) {
      Get.snackbar("Error", "Enter Bank or UPI details");
      return;
    }

    try {
      isLoading.value = true;

      final response = await dioPost(
        endUrl: "withdraw_request.php",
        data: {
          "user_id": getBox.read(USER_ID),
          "amount": amountController.text,
          "name": nameController.text,
          "bank_name": bankController.text,
          "account_no": accountController.text,
          "ifsc": ifscController.text,
          "upi_id": upiController.text,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", response.data['message']);

        /// clear
        amountController.clear();
        nameController.clear();
        bankController.clear();
        accountController.clear();
        ifscController.clear();
        upiController.clear();
      } else {
        Get.snackbar("Error", "Withdraw failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    amountController.addListener(() => hasAmount.value = amountController.text.isNotEmpty);
    accountController.addListener(_updateHasBankOrUpi);
    upiController.addListener(_updateHasBankOrUpi);
  }

  void _updateHasBankOrUpi() {
    hasBankOrUpi.value = accountController.text.isNotEmpty || upiController.text.isNotEmpty;
  }

  @override
  void onClose() {
    amountController.dispose();
    nameController.dispose();
    bankController.dispose();
    accountController.dispose();
    ifscController.dispose();
    upiController.dispose();
    super.onClose();
  }
}
