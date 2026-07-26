import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/app_config.dart';
import '../../../data/my_dio.dart';
import '../../BottomNavigation/views/bottom_navigation_view.dart';

class SetMpinController extends GetxController {
  // Text Controllers
  final passwordController = TextEditingController();
  final newMpinController = TextEditingController();
  final confirmMpinController = TextEditingController();

  // Focus Nodes
  final List<FocusNode> pinFocusNodes = List.generate(4, (index) => FocusNode());
  final List<FocusNode> confirmPinFocusNodes = List.generate(4, (index) => FocusNode());

  // State
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isMpinSet = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt pinLength = 4.obs;

  // For OTP-style MPIN input (when using individual digit boxes)
  final List<TextEditingController> newPinControllers = List.generate(
    4, (index) => TextEditingController(),
  );
  final List<TextEditingController> confirmPinControllers = List.generate(
    4, (index) => TextEditingController(),
  );

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

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

  bool validate() {
    if (passwordController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter your password';
      return false;
    }
    if (newMpin.length < 4 || newMpin.length > 6) {
      errorMessage.value = 'MPIN must be 4-6 digits';
      return false;
    }
    if (newMpin != confirmMpin) {
      errorMessage.value = 'MPINs do not match';
      return false;
    }
    return true;
  }

  Future<void> setMpin() async {
    if (!validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final phone = getBox.read(USER_PHONE) ?? '';

      final response = await dioPost(
        data: {
          "phone": phone,
          "password": passwordController.text.trim(),
          "mpin": newMpin,
        },
        endUrl: "set_mpin.php",
      );

      final data = response.data;
      if (data['status'] == 200) {
        isMpinSet.value = true;
        getBox.write('mpin_set', true);

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
                    'MPIN Set Successfully!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your 4-digit MPIN has been set.',
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
        errorMessage.value = data['message'] ?? 'Failed to set MPIN';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    newMpinController.dispose();
    confirmMpinController.dispose();
    for (var c in newPinControllers) c.dispose();
    for (var c in confirmPinControllers) c.dispose();
    for (var n in pinFocusNodes) n.dispose();
    for (var n in confirmPinFocusNodes) n.dispose();
    super.onClose();
  }
}
