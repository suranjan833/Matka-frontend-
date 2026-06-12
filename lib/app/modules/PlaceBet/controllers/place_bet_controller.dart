/// place_bet_controller.dart
library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceBetController extends GetxController {
  late Map<String, dynamic> bazaar;
  late Map<String, dynamic> gameType;

  final numberController = TextEditingController();
  final amountController = TextEditingController();

  RxString timeLeft = "00:00:00".obs;
  var isReviewing = false.obs;
  var isPlacing = false.obs;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    bazaar = args['bazaar'] ?? {};
    gameType = args['game_type'] ?? {};

    print(args);

    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      calculateRemainingTime();
    });
  }

  void calculateRemainingTime() {
    try {
      final endTime = bazaar['end_time'];

      final now = DateTime.now();

      final split = endTime.split(":");

      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(split[0]),
        int.parse(split[1]),
        0,
      );

      final difference = endDateTime.difference(now);

      if (difference.isNegative) {
        timeLeft.value = "Closed";
        timer?.cancel();
        return;
      }

      final hours = difference.inHours.toString().padLeft(2, '0');

      final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');

      final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

      timeLeft.value = "$hours:$minutes:$seconds";
    } catch (e) {
      timeLeft.value = "00:00:00";
    }
  }

  /// ─── VALIDATION ERROR HELPER ────────────────────────────────────────────
  String? validateNumber(String number) {
    if (number.isEmpty) return "Enter a number";

    final code = gameType['code']?.toString() ?? '';
    final isBulk = code.contains('BULK');

    // For bulk entries, split by comma or space and validate each
    if (isBulk) {
      final entries = number.split(RegExp(r'[,\s]+'));
      if (entries.isEmpty) return "Enter at least one number";
      for (final entry in entries) {
        final err = _validateSingle(entry.trim(), code);
        if (err != null) return "$err (in: '${entry.trim()}')";
      }
      return null;
    }

    return _validateSingle(number, code);
  }

  String? _validateSingle(String number, String code) {
    if (number.isEmpty) return "Enter a number";

    // HS and FS use hyphen format (e.g. "123-4"), skip digits-only check
    if (code != "HS" && code != "FS") {
      if (!RegExp(r'^\d+$').hasMatch(number)) return "Numbers only";
    }

    switch (code) {
      case "SINGLE":
      case "SINGLE_BULK":
        if (number.length != 1) return "Single: must be 1 digit (0-9)";
        final d = int.parse(number);
        if (d < 0 || d > 9) return "Single: must be between 0-9";
        return null;

      case "JODI":
      case "JODI_BULK":
        if (number.length != 2) return "Jodi: must be 2 digits (00-99)";
        return null;

      case "SP":
      case "SP_BULK":
        if (number.length != 3) return "Single Pana: must be 3 digits";
        if (number.split('').toSet().length != 3) {
          return "Single Pana: all 3 digits must be different (e.g. 123)";
        }
        return null;

      case "DP":
      case "DP_BULK":
        if (number.length != 3) return "Double Pana: must be 3 digits";
        final digits = number.split('').toSet();
        if (digits.length != 2) {
          return "Double Pana: one digit must repeat twice (e.g. 112)";
        }
        return null;

      case "TP":
        if (number.length != 3) return "Triple Pana: must be 3 digits";
        final digits = number.split('').toSet();
        if (digits.length != 1) {
          return "Triple Pana: all 3 digits must be same (e.g. 111)";
        }
        return null;

      case "SPM":
        if (number.length < 4) return "SP Motor: minimum 4 digits";
        return null;

      case "DPM":
        if (number.length < 4) return "DP Motor: minimum 4 digits";
        return null;

      case "GROUP_JODI":
        if (number.length != 2) return "Group Jodi: must be 2 digits";
        return null;

      case "RB":
        if (number.length != 2) return "Red Bracket: must be 2 digits";
        return null;

      case "HS":
        // Format: 3-digit Pana + hyphen + 1-digit Ank (e.g., 123-4)
        final parts = number.split('-');
        if (parts.length != 2) {
          return "Half Sangam: format Pana-Ank (e.g. 123-4)";
        }
        if (parts[0].length != 3) return "Half Sangam: Pana must be 3 digits";
        if (parts[1].length != 1) return "Half Sangam: Ank must be 1 digit";
        return null;

      case "FS":
        // Format: 3-digit Pana + hyphen + 3-digit Pana (e.g., 123-456)
        final parts = number.split('-');
        if (parts.length != 2) {
          return "Full Sangam: format Pana-Pana (e.g. 123-456)";
        }
        if (parts[0].length != 3)
          return "Full Sangam: first Pana must be 3 digits";
        if (parts[1].length != 3)
          return "Full Sangam: second Pana must be 3 digits";
        return null;

      default:
        // Fallback: just check it's a valid number
        if (number.isEmpty) return "Enter a valid number";
        return null;
    }
  }

  void placeBet() {
    final number = numberController.text.trim();
    final amount = amountController.text.trim();

    if (number.isEmpty) {
      Get.snackbar("Error", "Enter Number");
      return;
    }

    if (amount.isEmpty) {
      Get.snackbar("Error", "Enter Amount");
      return;
    }

    if ((int.tryParse(amount) ?? 0) < 1) {
      Get.snackbar("Error", "Enter valid amount");
      return;
    }

    /// Validate number against game rules
    final validationError = validateNumber(number);
    if (validationError != null) {
      Get.snackbar("Invalid Number", validationError);
      return;
    }

    /// Show review
    isReviewing.value = true;
  }

  void cancelReview() {
    isReviewing.value = false;
  }

  Future<void> confirmBet() async {
    final number = numberController.text.trim();
    final amount = amountController.text.trim();

    isPlacing.value = true;

    /// 🔥 API CALL HERE
    await Future.delayed(const Duration(milliseconds: 800));

    isPlacing.value = false;
    isReviewing.value = false;

    _showSuccessDialog(number, amount);
  }

  void _showSuccessDialog(String number, String amount) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Success icon
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF7B61FF).withValues(alpha: .1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF7B61FF),
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),

              /// Title
              const Text(
                "Bet Confirmed!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              /// Details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _detailRow("Game", gameType['name']?.toString() ?? ''),
                    const SizedBox(height: 8),
                    _detailRow("Number", number),
                    const SizedBox(height: 8),
                    _detailRow("Amount", "₹$amount"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// Done button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B61FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Get.back(); // close dialog
                    Get.back(); // go back to game types
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  void onClose() {
    timer?.cancel();

    numberController.dispose();
    amountController.dispose();

    super.onClose();
  }
}
