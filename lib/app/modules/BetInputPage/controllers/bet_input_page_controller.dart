import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../BetType/bet_type.dart';
import '../../../services/bet_slip_service.dart';

class BetInputPageController extends GetxController {
  late Map<String, dynamic> market;
  late BetTypeCategory betType;

  final numberController = TextEditingController();
  final amountController = TextEditingController();

  final RxString errorMessage = ''.obs;
  final RxString selectedSingleDigit = ''.obs;

  // Pana chart selection
  final RxInt selectedFamilyDigit = 0.obs;
  final RxString selectedPanaNumber = ''.obs;
  final RxList<String> selectedPanaNumbers = <String>[].obs;

  // For bulk types, track per-number amounts
  final RxDouble perUnitAmount = 0.0.obs;

  late BetSlipService betSlipService;

  @override
  void onInit() {
    super.onInit();

    betSlipService = Get.find<BetSlipService>();

    final args = Get.arguments as Map<String, dynamic>;
    market = args['market'] as Map<String, dynamic>;
    betType = BetTypeCategory.values[args['betType'] as int];
  }

  @override
  void onClose() {
    numberController.dispose();
    amountController.dispose();
    super.onClose();
  }

  void onDigitSelected(String digit) {
    selectedSingleDigit.value = digit;
    numberController.text = digit;
    errorMessage.value = '';
  }

  void onFamilyDigitSelected(int digit) {
    selectedFamilyDigit.value = digit;
    // Clear Pana selection when switching families
    selectedPanaNumber.value = '';
    errorMessage.value = '';
  }

  void onPanaNumberSelected(String pana) {
    if (betType.isBulkType) {
      // Toggle selection for bulk types
      if (selectedPanaNumbers.contains(pana)) {
        selectedPanaNumbers.remove(pana);
      } else {
        selectedPanaNumbers.add(pana);
      }
      numberController.text = selectedPanaNumbers.join(', ');
    } else {
      // Single selection for non-bulk
      selectedPanaNumber.value = pana;
      numberController.text = pana;
    }
    errorMessage.value = '';
  }

  void onNumberChanged(String value) {
    errorMessage.value = '';
  }

  void onAmountChanged(String value) {
    errorMessage.value = '';
  }

  bool validateAndAdd() {
    final number = numberController.text.trim();
    final amountStr = amountController.text.trim();

    // Validate number
    final numberError = betType.validate(number);
    if (numberError != null) {
      errorMessage.value = numberError;
      return false;
    }

    // Validate amount
    if (amountStr.isEmpty) {
      errorMessage.value = 'Please enter a bet amount';
      return false;
    }
    final amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) {
      errorMessage.value = 'Enter a valid amount greater than 0';
      return false;
    }

    // Format the number properly
    String formattedNumber = number.trim();
    if (betType == BetTypeCategory.jodiDigits) {
      formattedNumber = number.trim().padLeft(2, '0');
    } else if (betType == BetTypeCategory.jodiPana ||
        betType == BetTypeCategory.jodiPanaBulk) {
      formattedNumber = number.trim().padLeft(5, '0');
    } else if (betType == BetTypeCategory.singlePana ||
        betType == BetTypeCategory.doublePana ||
        betType == BetTypeCategory.triplePana) {
      formattedNumber = number.trim().padLeft(3, '0');
    }

    // Add to bet slip
    betSlipService.addItem(BetSlipItem(
      marketName: market['name'],
      betType: betType,
      numbers: formattedNumber,
      amount: amount,
    ));

    // Clear inputs
    numberController.clear();
    amountController.clear();
    selectedSingleDigit.value = '';
    selectedPanaNumber.value = '';
    selectedPanaNumbers.clear();
    errorMessage.value = '';

    return true;
  }

  void removeBet(int index) {
    betSlipService.removeItem(index);
  }

  void clearAllBets() {
    betSlipService.clear();
  }

  void placeBets() {
    if (betSlipService.items.isEmpty) {
      errorMessage.value = 'No bets to place. Add at least one bet.';
      return;
    }

    final count = betSlipService.itemCount;
    final total = betSlipService.totalAmount;

    betSlipService.clear();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xff22C55E).withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: const Color(0xff22C55E),
                size: 36.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Bet Placed!',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '$count bet(s) placed successfully.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Total: ₹${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xff1673E6),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1673E6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
