import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/app_config.dart';
import '../../../data/my_dio.dart';
import '../../BottomNavigation/views/bottom_navigation_view.dart';

class ForgotMpinController extends GetxController {
  // Step tracking
  final RxInt currentStep = 0.obs; // 0 = enter phone, 1 = enter OTP, 2 = set new MPIN

  // Text Controllers
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  // MPIN digit boxes
  final List<TextEditingController> newPinControllers = List.generate(
    4, (index) => TextEditingController(),
  );
  final List<TextEditingController> confirmPinControllers = List.generate(
    4, (index) => TextEditingController(),
  );

  // Focus nodes
  final List<FocusNode> pinFocusNodes = List.generate(4, (index) => FocusNode());
  final List<FocusNode> confirmPinFocusNodes = List.generate(4, (index) => FocusNode());

  // State
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt otpSecondsRemaining = 0.obs;

  void onNewPinChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      pinFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      pinFocusNodes[index - 1].requestFocus();
    }
    errorMessage.value = '';
  }

  void onConfirmPinChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      confirmPinFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      confirmPinFocusNodes[index - 1].requestFocus();
    }
    errorMessage.value = '';
  }

  String get newMpin => newPinControllers.map((e) => e.text).join();
  String get confirmMpin => confirmPinControllers.map((e) => e.text).join();

  // ─── Step 0: Send OTP ──────────────────────────────────────
  void sendOtp() {
    if (phoneController.text.trim().isEmpty || phoneController.text.trim().length < 10) {
      errorMessage.value = 'Please enter a valid 10-digit phone number';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    // Simulate OTP send — in production this would call a send-otp endpoint
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      currentStep.value = 1;
      startOtpTimer();
      Get.snackbar('OTP Sent', 'A verification code has been sent to your phone');
    });
  }

  void startOtpTimer() {
    otpSecondsRemaining.value = 30;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (otpSecondsRemaining.value > 0) {
        otpSecondsRemaining.value--;
        return true;
      }
      return false;
    });
  }

  void resendOtp() {
    otpSecondsRemaining.value = 30;
    startOtpTimer();
    Get.snackbar('OTP Resent', 'A new verification code has been sent');
  }

  // ─── Step 1: Verify OTP ────────────────────────────────────
  void verifyOtp() {
    if (otpController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter the OTP';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    // Simulate OTP verify — in production this would call verify-otp endpoint
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      currentStep.value = 2;
    });
  }

  // ─── Step 2: Set new MPIN ──────────────────────────────────
  bool validateNewMpin() {
    if (newMpin.length < 4) {
      errorMessage.value = 'MPIN must be 4-6 digits';
      return false;
    }
    if (newMpin != confirmMpin) {
      errorMessage.value = 'MPINs do not match';
      return false;
    }
    return true;
  }

  Future<void> resetMpin() async {
    if (!validateNewMpin()) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await dioPost(
        data: {
          "phone": phoneController.text.trim(),
          "otp": otpController.text.trim(),
          "new_mpin": newMpin,
        },
        endUrl: "forgot_mpin.php",
      );

      final data = response.data;
      if (data['status'] == 200) {
        // Store phone for future MPIN login
        getBox.write(USER_PHONE, phoneController.text.trim());

        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xff22C55E).withValues(alpha: .1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xff22C55E),
                      size: 36,
                    ),
                  ),
                  SizedBox(height: 16),
                  const Text(
                    'MPIN Reset Successful!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your new MPIN has been set. Use it to login quickly.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // close dialog
                        Get.offAll(() => const BottomNavigationView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1673E6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        errorMessage.value = data['message'] ?? 'Failed to reset MPIN';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    if (currentStep.value > 0) {
      currentStep.value--;
      errorMessage.value = '';
    } else {
      Get.back();
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    for (var c in newPinControllers) c.dispose();
    for (var c in confirmPinControllers) c.dispose();
    for (var n in pinFocusNodes) n.dispose();
    for (var n in confirmPinFocusNodes) n.dispose();
    super.onClose();
  }
}
