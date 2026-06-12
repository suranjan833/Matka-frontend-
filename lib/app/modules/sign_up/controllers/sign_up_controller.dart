import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matka/app/modules/login_page/views/login_page_view.dart';

import '../../../data/my_dio.dart';

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
  Future<void> signUp() async {
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

    isLoading.value = true;

    try {
      var response = await dioPost(
        endUrl: "register.php",
        data: {
          "name": nameController.text.trim(),
          "phone": phoneController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      // ✅ FIX START
      if (response.statusCode == 200 && response.data != null) {
        var res = response.data;

        if (res['status'] == 200) {
          Get.snackbar("Success", res['message'] ?? "Account created");

          Get.offAll(LoginPageView());
        } else {
          Get.snackbar("Error", res['message'] ?? "Signup failed");
        }
      } else {
        Get.snackbar("Error", "Server error");
      }
      // ✅ FIX END
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }

    isLoading.value = false;
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
