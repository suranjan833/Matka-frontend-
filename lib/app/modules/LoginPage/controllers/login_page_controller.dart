import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Config/app_config.dart';
import '../../../data/my_dio.dart';
import '../../BottomNavigation/views/bottom_navigation_view.dart';
import '../models/user_model.dart';

class LoginPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar("Error", "Phone and Password required");
      return;
    }

    if (emailController.text.trim().length != 10) {
      Get.snackbar("Error", "Phone number must be 10 digits");
      return;
    }

    isLoading.value = true;

    try {
      final response = await dioPost(
        data: {
          "phone": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
        endUrl: "login.php",
      );

      final data = response.data;
      if (data['status'] == 200 && data['data'] != null) {
        final user = UserModel.fromJson(data['data']);

        // Store user data (including phone for MPIN login)
        final box = GetStorage();
        box.write(USER_TOKEN, user.token);
        box.write(USER_ID, user.id.toString());
        box.write(USER_NAME, user.name);
        box.write(USER_EMAIL, user.email);
        box.write(USER_PHONE, emailController.text.trim());
        box.write(IS_USER_LOGGED_IN, true);

        Get.snackbar("Success", data['message'] ?? "Login successful");
        Get.offAll(() => const BottomNavigationView());
      } else {
        Get.snackbar("Error", data['message'] ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
