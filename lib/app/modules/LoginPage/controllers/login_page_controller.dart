import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/my_dio.dart';
import '../../MpinLogin/views/mpin_login_view.dart';

class LoginPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar("Error", "Phone and Password required");
      return;
    }

    Get.snackbar("Success", "Login successful");
    Get.offAll(() => const MpinLoginView());
  }
}
