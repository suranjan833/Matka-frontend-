import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../AllBids/views/all_bids_view.dart';
import '../../History/views/history_view.dart';
import '../../Wallet/views/wallet_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationController());

    final pages = [
      const HistoryView(),
      const AllBidsView(),
      HomeView(),
      WalletView(),
      const Center(child: Text("")),
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.r),
              topRight: Radius.circular(28.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 20,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: _navItem(
                      index: 0,
                      icon: Icons.history_outlined,
                      label: "History",
                    ),
                  ),

                  Expanded(
                    child: _navItem(
                      index: 1,
                      icon: Icons.gavel_outlined,
                      label: "All Bids",
                    ),
                  ),
                  Expanded(
                    child: _navItem(
                      index: 2,
                      icon: Icons.home_rounded,
                      label: "Home",
                    ),
                  ),

                  Expanded(
                    child: _navItem(
                      index: 3,
                      icon: Icons.account_balance_wallet_outlined,
                      label: "Wallet",
                    ),
                  ),

                  Expanded(
                    child: _navItem(
                      index: 4,
                      icon: Icons.chat_bubble_outline,
                      label: "Chat",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: () => controller.changeIndex(index),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                icon,
                size: 25.sp,
                color: isSelected
                    ? const Color(0xff1673E6)
                    : Colors.grey.shade500,
              ),
            ),

            SizedBox(height: 4.h),

            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xff1673E6)
                    : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
