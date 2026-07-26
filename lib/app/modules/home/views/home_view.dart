import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/market_time_utils.dart';
import '../../../routes/app_pages.dart';
import '../../BottomNavigation/controllers/bottom_navigation_controller.dart';
import '../../Support/views/support_view.dart';
import '../../Wallet/AddFund/views/add_fund_view.dart';
import '../../Wallet/WithdrawFunds/views/withdraw_funds_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const primaryColor = Color(0xff1673E6);
  static const accentGold = Color(0xffF59E0B);
  static const bgColor = Color(0xffF6F8FB);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 18.h),
                    _buildBalanceCard(),
                    SizedBox(height: 16.h),
                    _buildAnnouncementBar(),
                    SizedBox(height: 16.h),
                    _buildQuickActions(),
                    SizedBox(height: 20.h),
                    _buildSectionHeader("Active Markets"),
                    SizedBox(height: 12.h),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.markets.length,
                        itemBuilder: (context, index) {
                          final market = controller.markets[index];
                          return _marketCard(market, index);
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildWhatsappBanner(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              final navController = Get.find<BottomNavigationController>();
              navController.openDrawer();
            },
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, Color(0xff0B5ED7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: .25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.casino_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MATKA",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                  letterSpacing: .8,
                ),
              ),
              Text(
                "Live Markets",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  letterSpacing: .3,
                ),
              ),
            ],
          ),
          const Spacer(),
          _headerIcon(Icons.notifications_outlined),
        ],
      ),
    );
  }

  Widget _headerIcon(IconData icon) {
    return Container(
      width: 38.w,
      height: 38.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Icon(icon, color: Colors.black54, size: 20.sp),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1a1a2e), Color(0xff16213e), Color(0xff0B5ED7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1a1a2e).withValues(alpha: .25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: accentGold.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: accentGold,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                "Welcome, Player!",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .85),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "Your Balance",
            style: TextStyle(
              color: Colors.white.withValues(alpha: .6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Obx(
            () => Text(
              "₹${controller.walletBalance.value.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -.5,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.to(() => const AddFundView()),
                child: _actionChip("Deposit", Icons.add_rounded, Colors.greenAccent),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () => Get.to(() => const WithdrawFundsView()),
                child: _actionChip(
                  "Withdraw",
                  Icons.arrow_downward_rounded,
                  Colors.orangeAccent,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withValues(alpha: .2)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, color: accentGold, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "VIP",
                      style: TextStyle(
                        color: accentGold,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionChip(String label, IconData icon, Color accent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: accent, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: accentGold.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(14.r),
        border: Border(
          left: BorderSide(color: accentGold, width: 3.w),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.campaign_rounded, color: accentGold, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              "Minimum Deposit Starts From ₹100",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff92400E),
              ),
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: accentGold, size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      ("Play Now", Icons.play_arrow_rounded, primaryColor, null),
      ("Results", Icons.emoji_events_outlined, const Color(0xff22C55E), null),
      ("Rules", Icons.description_outlined, const Color(0xff0EA5E9), () => Get.toNamed(Routes.RULES)),
      ("Support", Icons.headset_mic_rounded, const Color(0xff8B5CF6), () => Get.to(() => const SupportView())),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: actions.map((item) {
          return Expanded(child: _quickActionItem(item.$1, item.$2, item.$3, onTap: item.$4));
        }).toList(),
      ),
    );
  }

  Widget _quickActionItem(String label, IconData icon, Color color, {VoidCallback? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Container(
            width: 3.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            "View All",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.chevron_right_rounded, color: primaryColor, size: 16.sp),
        ],
      ),
    );
  }

  Widget _marketCard(Map<String, dynamic> market, int index) {
    final isOpen = !(market['status'] as String).contains("Closed");

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 350 + (index * 80)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 25 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(18.r),
            onTap: () {
              final check = MarketTimeUtils.canPlaceBet(market);
              if (!check.canBet) {
                Get.snackbar(
                  'Market Closed',
                  check.message,
                  backgroundColor: const Color(0xffFEE2E2),
                  colorText: const Color(0xffDC2626),
                  icon: const Icon(Icons.lock_clock_rounded, color: Color(0xffDC2626)),
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 3),
                );
                return;
              }
              Get.toNamed(Routes.GAME_PAGE, arguments: market);
            },
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Top row: name + status badge
                  Row(
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.sports_kabaddi_rounded,
                          color: primaryColor,
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              market['name'],
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              market['result'],
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: isOpen
                              ? const Color(0xff22C55E).withValues(alpha: .1)
                              : const Color(0xffEF4444).withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          isOpen ? "Open" : "Closed",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: isOpen
                                ? const Color(0xff22C55E)
                                : const Color(0xffEF4444),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  // Divider
                  Divider(color: Colors.grey.shade100, height: 1),
                  SizedBox(height: 12.h),
                  // Bottom row: open/close time + play button
                  Row(
                    children: [
                      Expanded(
                        child: _timeSlot(
                          "Open Time",
                          market['openTime'],
                          Icons.schedule_rounded,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 24.h,
                        color: Colors.grey.shade200,
                      ),
                      Expanded(
                        child: _timeSlot(
                          "Close Time",
                          market['closeTime'],
                          Icons.timer_outlined,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor, const Color(0xff0B5ED7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: .3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeSlot(String label, String time, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12.sp, color: Colors.grey.shade500),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          time,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildWhatsappBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xff25D366).withValues(alpha: .08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xff25D366).withValues(alpha: .2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xff25D366),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.chat_rounded, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Connect on WhatsApp",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Get instant updates & support",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xff25D366),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              "Chat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
