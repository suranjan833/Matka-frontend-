// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final primaryColor = const Color(0xFF7B61FF);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        /// 🔹 Profile Name
        title: Obx(() {
          if (controller.isProfileLoading.value) {
            return const Text(
              "Loading...",
              style: TextStyle(color: Colors.black),
            );
          }

          final name = controller.profileData['name'] ?? 'User';

          return Text(
            "Welcome\n$name",
            style: const TextStyle(color: Colors.black),
          );
        }),

        /// 🔹 FIXED ACTIONS (NO OVERFLOW)
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.currency_exchange, color: Colors.purple),
                SizedBox(width: 5.w),
                const Text("Rs"),
                SizedBox(width: 8.w),

                /// Wallet
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        final balance = controller.wallet['balance'] ?? '0';

                        return Text(
                          balance.toString(),
                          style: const TextStyle(color: Colors.white),
                        );
                      }),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),
                const Icon(Icons.call, color: Colors.green),
                SizedBox(width: 6.w),
                const Icon(Icons.logout_rounded, color: Colors.purple),
              ],
            ),
          ),
        ],
      ),

      /// 🔹 BODY
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            /// Banner
            Container(
              height: 60.h,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const Text("-", style: TextStyle(color: Colors.white)),
            ),

            SizedBox(height: 15.h),

            /// Actions
            Row(
              children: [
                Expanded(child: _actionCard("Add Money")),
                SizedBox(width: 10.w),
                Expanded(child: _actionCard("Withdraw")),
              ],
            ),

            SizedBox(height: 15.h),

            /// 🔥 CATEGORY GRID
            Obx(() {
              if (controller.isCategoryLoading.value) {
                return const CircularProgressIndicator();
              }

              if (controller.categories.isEmpty) {
                return const Text("No Categories Found");
              }

              return GridView.builder(
                itemCount: controller.categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 1.6,
                ),
                itemBuilder: (context, index) {
                  final item = controller.categories[index];
                  return _gridCard(item);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  /// 🔹 Action Card
  Widget _actionCard(String title) {
    return Container(
      height: 80.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
    );
  }

  /// 🔹 Grid Card (FIXED)
  Widget _gridCard(Map<String, dynamic> item) {
    final title = item['name']?.toString() ?? '';

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          "/bazaar",
          arguments: {"category_id": item['id'] ?? 0, "category_name": title},
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.purple,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
