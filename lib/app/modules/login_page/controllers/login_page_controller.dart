import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_config.dart';
import '../../../data/my_dio.dart';
import '../../bottom_navigation/views/bottom_navigation_view.dart';

class LoginPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar("Error", "Phone and Password required");
      return;
    }

    isLoading.value = true;

    try {
      var response = await dioPost(
        endUrl: "login.php",
        data: {
          "phone": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        var res = response.data;

        if (res['status'] == 200) {
          var token = res['data']?['token'];
          var userId = res['data']['id'];
          getBox.write(USER_ID, userId);
          if (token != null) {
            getBox.write(USER_TOKEN, token);
          }

          Get.snackbar("Success", res['message'] ?? "Login successful");

          Get.offAll(BottomNavigationView());
        } else {
          Get.snackbar("Error", res['message'] ?? "Login failed");
        }
      } else {
        Get.snackbar("Error", "Server error");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }

    isLoading.value = false;
  }
}
