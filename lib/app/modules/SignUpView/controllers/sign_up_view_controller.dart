import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Config/app_config.dart';
import '../../../data/my_dio.dart';
import '../../LoginPage/views/login_page_view.dart';

class SignUpController extends GetxController {
  // 🔹 Text Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

    if (phoneController.text.trim().length != 10) {
      Get.snackbar("Error", "Phone number must be 10 digits");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;

    try {
      final response = await dioPost(
        data: {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneController.text.trim(),
          "password": passwordController.text,
        },
        endUrl: "register.php",
      );

      final data = response.data;
      if (data['status'] == 200) {
        // Store phone for MPIN login flow
        final box = GetStorage();
        box.write(USER_PHONE, phoneController.text.trim());

        Get.snackbar("Success", data['message'] ?? "Account created successfully");
        Get.offAll(const LoginPageView());
      } else {
        Get.snackbar("Error", data['message'] ?? "Registration failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
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
