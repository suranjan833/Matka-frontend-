import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Config/app_config.dart';
import '../../LoginPage/views/login_page_view.dart';

class BottomNavigationController extends GetxController {
  RxInt selectedIndex = 2.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  String get userName {
    final name = getBox.read(USER_NAME) ?? '';
    final email = getBox.read(USER_EMAIL) ?? '';
    return name.isNotEmpty ? name.toString() : email.toString();
  }

  Future<void> logout() async {
    final box = GetStorage();
    await box.erase();
    Get.offAll(() => const LoginPageView());
  }

  void showLogoutConfirm() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              logout();
            },
            child: const Text(
              "Yes, Logout",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
