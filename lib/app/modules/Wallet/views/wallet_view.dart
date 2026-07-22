import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../History/views/history_view.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  static const primaryColor = Color(0xff1673E6);
  static const bgColor = Color(0xffF5F7FA);

  @override
  Widget build(BuildContext context) {
    Get.put(WalletController());

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 18.h),
            _buildBalanceCard(),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.walletMenus.length,
                  separatorBuilder: (_, _) => SizedBox(height: 14.h),
                  itemBuilder: (_, index) {
                    final item = controller.walletMenus[index];
                    return _walletCard(item: item, index: index);
                  },
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
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: .2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            "Wallet",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          _iconBadge(Icons.notifications_outlined),
          SizedBox(width: 8.w),
          _iconBadge(Icons.more_vert_rounded),
        ],
      ),
    );
  }

  Widget _iconBadge(IconData icon) {
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
          colors: [Color(0xff1673E6), Color(0xff0B5ED7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: .25),
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
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white.withValues(alpha: .7),
                size: 18.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                "Available Balance",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .85),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Obx(
            () => Text(
              "₹${controller.walletBalance.value.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -.5,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () => Get.to(() => const HistoryView()),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.history_rounded,
                        color: Colors.white.withValues(alpha: .7),
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "History",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .85),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _walletCard({required WalletMenuModel item, required int index}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 60)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        onTap: () => controller.onMenuTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 82.h,
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
          child: Row(
            children: [
              // Accent strip
              Container(
                width: 4.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    bottomLeft: Radius.circular(18.r),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Icon
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: .12),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: item.color, size: 22.sp),
              ),
              SizedBox(width: 14.w),
              // Title
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
              ),
              // Arrow
              Container(
                width: 32.w,
                height: 32.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
