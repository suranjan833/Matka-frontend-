import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final c = Get.put(HomeController());
    final primaryColor = const Color(0xFF7B61FF);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Obx(() {
          if (controller.isProfileLoading.value) {
            return const Text(
              "Loading...",
              style: TextStyle(color: Colors.black),
            );
          }

          final name = controller.profileData['name'] ?? 'User';

          return Text(
            "Welcome \n$name",
            style: const TextStyle(color: Colors.black),
          );
        }),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                const Icon(Icons.currency_exchange, color: Colors.purple),
                SizedBox(width: 5.w),
                const Text("Rs"),
                SizedBox(width: 8.w),

                /// Balance box
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Obx(() {
                        final walletblz = controller.wallet['balance'] ?? '0';

                        return Text(
                          walletblz.toString(),
                          style: const TextStyle(color: Colors.white),
                        );
                      }),
                      SizedBox(width: 5),
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10.w),
                const Icon(Icons.call, color: Colors.green),
                SizedBox(width: 8.w),
                const Icon(Icons.logout_rounded, color: Colors.purple),
              ],
            ),
          ),
        ],
      ),

      /// Body
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            /// Purple Banner
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
              child: const Text(
                "-",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            SizedBox(height: 15.h),

            /// Add Money & Withdraw
            Row(
              children: [
                Expanded(child: _actionCard("Add Money")),
                SizedBox(width: 10.w),
                Expanded(child: _actionCard("Withdraw")),
              ],
            ),

            SizedBox(height: 15.h),

            /// Grid Items
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.6,
              children: [
                _gridCard("KOLKATA FATAFAT"),
                _gridCard("MORNING FATAFAT"),
                _gridCard("MUMBAI FATAFAT"),
                _gridCard("DAY FATAFAT"),
                _gridCard("INDIA FATAFAT"),
                _gridCard("ASIA FATAFAT"),
                _gridCard("EVENING FATAFAT"),
                _gridCard("WORLD FATAFAT"),
                _gridCard("BENGAL FATAFAT"),
                _gridCard("NIGHT FATAFAT"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Green Action Card
  Widget _actionCard(String title) {
    return Container(
      height: 80.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Yellow Grid Card
  Widget _gridCard(String title) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.purple,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
