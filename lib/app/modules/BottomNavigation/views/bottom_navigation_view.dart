import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Config/app_config.dart';
import '../../../routes/app_pages.dart';
import '../../AllBids/views/all_bids_view.dart';
import '../../History/views/history_view.dart';
import '../../Results/views/results_view.dart';
import '../../Wallet/views/wallet_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationController());

    final pages = [
      const HistoryView(),
      const AllBidsView(),
      HomeView(),
      WalletView(),
      const ResultsView(),
    ];

    return Obx(
      () => Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: const Color(0xffF5F5F5),
        drawer: _buildDrawer(),
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
                      icon: Icons.emoji_events_outlined,
                      label: "Results",
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

  Widget _buildDrawer() {
    final userEmail = getBox.read(USER_EMAIL) ?? 'Player';
    final userName = getBox.read(USER_NAME) ?? userEmail;

    return Drawer(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // ─── Drawer Header ──────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff1a1a2e), Color(0xff16213e), Color(0xff0B5ED7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ludo Icon
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .18),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.casino_rounded,
                        color: Colors.white,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      userName.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      userEmail.toString(),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .7),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              // ─── Menu Items ─────────────────────────────────
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 8.h),
                  children: [
                    _drawerItem(
                      icon: Icons.account_balance_rounded,
                      title: "Account Statement",
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.ACCOUNT_STATEMENT);
                      },
                    ),
                    _drawerItem(
                      icon: Icons.history_rounded,
                      title: "History",
                      onTap: () {
                        Get.back();
                        controller.changeIndex(0);
                      },
                    ),
                    _drawerItem(
                      icon: Icons.lock_outline,
                      title: "Set / Change MPIN",
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.SET_MPIN);
                      },
                    ),
                    _drawerItem(
                      icon: Icons.description_outlined,
                      title: "Terms & Condition",
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.TERMS_CONDITIONS);
                      },
                    ),
                    const Divider(height: 24),
                    _drawerItem(
                      icon: Icons.logout_rounded,
                      title: "Logout",
                      iconColor: Colors.redAccent,
                      textColor: Colors.redAccent,
                      onTap: () {
                        Get.back();
                        controller.showLogoutConfirm();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: (iconColor ?? primaryColor).withValues(alpha: .1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          icon,
          color: iconColor ?? primaryColor,
          size: 20.sp,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey.shade400,
        size: 20.sp,
      ),
      onTap: onTap,
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
