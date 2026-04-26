import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matka/app/modules/add_money/views/add_money_view.dart';
import 'package:matka/app/modules/home/views/home_view.dart';
import 'package:matka/app/modules/result_page/views/result_page_view.dart';
import 'package:matka/app/modules/withdraw_page/views/withdraw_page_view.dart';

import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(BottomNavigationController());
    final primaryColor = const Color(0xFF7B61FF);

    final pages = [
      HomeView(),
      AddMoneyView(),
      WithdrawPageView(),
      ResultPageView(),
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,

        /// Body
        body: pages[controller.selectedIndex.value],

        /// Bottom Nav
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeIndex,
              backgroundColor: Colors.white,
              selectedItemColor: primaryColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,

              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: "Add Money",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.money_off),
                  label: "Withdraw",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: "Result",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
