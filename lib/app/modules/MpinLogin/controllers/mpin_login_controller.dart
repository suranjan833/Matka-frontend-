import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/app_config.dart';
import '../../../data/my_dio.dart';
import '../../BottomNavigation/views/bottom_navigation_view.dart';

class MpinLoginController extends GetxController {
  final List<TextEditingController> pinControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  RxBool isLoading = false.obs;

  void onPinChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  String get mpin => pinControllers.map((e) => e.text).join();

  Future<void> login() async {
    if (mpin.length != 4) {
      Get.snackbar(
        "Error",
        "Please enter 4 digit MPIN",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    try {
      final phone = getBox.read(USER_PHONE) ?? '';

      final response = await dioPost(
        data: {
          "phone": phone,
          "mpin": mpin,
        },
        endUrl: "mpin_login.php",
      );

      final data = response.data;
      if (data['status'] == 200 && data['data'] != null) {
        // Store token from MPIN login
        final token = data['data']['token'] ?? '';
        if (token.isNotEmpty) {
          getBox.write(USER_TOKEN, token);
        }
        getBox.write(IS_USER_LOGGED_IN, true);

        Get.snackbar(
          "Success",
          "MPIN Login Successful",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAll(() => const BottomNavigationView());
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "MPIN login failed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void biometricLogin() {
    /// biometric authentication code
  }

  @override
  void onClose() {
    for (var controller in pinControllers) {
      controller.dispose();
    }

    for (var node in focusNodes) {
      node.dispose();
    }

    super.onClose();
  }
}
