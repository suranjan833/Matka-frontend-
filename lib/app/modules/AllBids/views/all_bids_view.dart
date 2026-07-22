import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/all_bids_controller.dart';

class AllBidsView extends GetView<AllBidsController> {
  const AllBidsView({super.key});

  static const primaryColor = Color(0xff1673E6);
  static const bgColor = Color(0xffF6F8FB);

  @override
  Widget build(BuildContext context) {
    Get.put(AllBidsController());

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 18.h),
            _buildStatsRow(),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.menuList.length,
                  separatorBuilder: (_, _) => SizedBox(height: 14.h),
                  itemBuilder: (_, index) {
                    final title = controller.menuList[index]['title'];
                    return _menuCard(title: title, index: index);
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
            child: Icon(Icons.gavel_rounded, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Text(
            "All Bids",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: primaryColor,
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "₹${controller.walletBalance.value.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _statCard(
            icon: Icons.assessment_rounded,
            label: "Total Bids",
            value: "0",
            color: const Color(0xff1673E6),
          ),
          SizedBox(width: 12.w),
          _statCard(
            icon: Icons.check_circle_outline_rounded,
            label: "Won",
            value: "0",
            color: const Color(0xff22C55E),
          ),
          SizedBox(width: 12.w),
          _statCard(
            icon: Icons.cancel_outlined,
            label: "Lost",
            value: "0",
            color: const Color(0xffEF4444),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({required String title, required int index}) {
    final icons = [
      Icons.receipt_long_rounded,
    ];

    final colors = [
      const Color(0xff1673E6),
    ];

    final subtitles = [
      "View all your placed bids",
    ];

    final icon = icons[index % icons.length];
    final color = colors[index % colors.length];

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
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
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
              // Icon with gradient background
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22.sp),
              ),
              SizedBox(width: 14.w),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      subtitles[index],
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 18.sp,
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
