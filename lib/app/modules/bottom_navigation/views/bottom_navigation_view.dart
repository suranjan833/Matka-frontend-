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

  static const _primaryColor = Color(0xFF7B61FF);

  static const _navItems = [
    _NavItem(icon: Icons.home_rounded, activeIcon: Icons.home_rounded, label: "Home"),
    _NavItem(
      icon: Icons.wallet_outlined,
      activeIcon: Icons.wallet_rounded,
      label: "Add Money",
    ),
    _NavItem(
      icon: Icons.arrow_circle_up_outlined,
      activeIcon: Icons.arrow_circle_up_rounded,
      label: "Withdraw",
    ),
    _NavItem(
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart_rounded,
      label: "Result",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationController());

    final pages = const [
      HomeView(),
      AddMoneyView(),
      WithdrawPageView(),
      ResultPageView(),
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),

        /// ─── CUSTOM BOTTOM NAV ──────────────────────────────────────────
        bottomNavigationBar: Container(
          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22.r),
            child: SizedBox(
              height: 68.h,
              child: Row(
                children: List.generate(_navItems.length, (i) {
                  final item = _navItems[i];
                  final isActive = controller.selectedIndex.value == i;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeIndex(i),
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 4.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          color: isActive
                              ? _primaryColor.withValues(alpha: .12)
                              : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// ─── ICON WITH PILL ──────────────────────
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              height: 28.h,
                              width: 28.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                isActive ? item.activeIcon : item.icon,
                                size: 22.sp,
                                color: isActive ? _primaryColor : Colors.grey.shade400,
                              ),
                            ),
                            SizedBox(height: 3.h),

                            /// ─── LABEL ──────────────────────────────
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                color: isActive ? _primaryColor : Colors.grey.shade400,
                                letterSpacing: 0.3,
                              ),
                              child: Text(item.label),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ─── NAV ITEM DATA ─────────────────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
