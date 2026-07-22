import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/my_dio.dart';
import '../../LoginPage/views/login_page_view.dart';

class SignUpController extends GetxController {
  // 🔹 Text Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController(); // ✅ added
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // ✅ added

  // 🔹 Loading State
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // 🔹 Signup Function
  void signUp() {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    Get.snackbar("Success", "Account created");
    Get.offAll(const LoginPageView());
  }

  // 🔹 Clear all fields
  void clearFields() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
