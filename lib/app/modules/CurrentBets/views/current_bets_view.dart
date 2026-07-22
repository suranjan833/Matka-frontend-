import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/current_bets_controller.dart';

class CurrentBetsView extends GetView<CurrentBetsController> {
  const CurrentBetsView({super.key});

  static const primaryColor = Color(0xff1673E6);
  static const bgColor = Color(0xffF6F8FB);

  @override
  Widget build(BuildContext context) {
    Get.put(CurrentBetsController());

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
              child: RefreshIndicator(
                onRefresh: controller.onRefresh,
                color: primaryColor,
                child: Obx(() {
                  if (controller.currentBets.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 100.h),
                        Center(
                          child: Column(
                            children: [
                              Icon(Icons.receipt_long_rounded, size: 64.sp, color: Colors.grey.shade300),
                              SizedBox(height: 16.h),
                              Text("No active bets", style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade500)),
                              SizedBox(height: 6.h),
                              Text("Place your first bet to see it here", style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400)),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: controller.currentBets.length,
                    itemBuilder: (_, index) => _betCard(controller.currentBets[index], index),
                  );
                }),
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w, height: 40.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xff1673E6), Color(0xff0B5ED7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [BoxShadow(color: primaryColor.withValues(alpha: .2), blurRadius: 8, offset: const Offset(0, 3))],
            ),
            child: Icon(Icons.receipt_long_rounded, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Text("Current Bets", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(color: const Color(0xff22C55E).withValues(alpha: .1), borderRadius: BorderRadius.circular(8.r)),
            child: Text("${controller.currentBets.length} Active", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: const Color(0xff22C55E))),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final totalBids = controller.currentBets.length;
    final totalAmount = controller.currentBets.fold<int>(0, (sum, item) => sum + (item['amount'] as int));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _statCard("Total Bets", "$totalBids", Icons.assessment_rounded, primaryColor),
          SizedBox(width: 12.w),
          _statCard("Total Amount", "₹$totalAmount", Icons.payments_rounded, const Color(0xffF59E0B)),
          SizedBox(width: 12.w),
          _statCard("Active", "$totalBids", Icons.check_circle_outline_rounded, const Color(0xff22C55E)),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 6.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 10, offset: const Offset(0, 3))],
        ),
        child: Column(
          children: [
            Container(
              width: 36.w, height: 36.w,
              decoration: BoxDecoration(color: color.withValues(alpha: .1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800, color: color)),
            SizedBox(height: 2.h),
            Text(label, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _betCard(Map<String, dynamic> item, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 60)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 42.w, height: 42.w,
                  decoration: BoxDecoration(color: primaryColor.withValues(alpha: .1), borderRadius: BorderRadius.circular(12.r)),
                  child: Icon(Icons.sports_kabaddi_rounded, color: primaryColor, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['game'], style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                      SizedBox(height: 2.h),
                      Text("${item['type']}  •  ${item['number']}", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff22C55E).withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 6.w, height: 6.w, decoration: const BoxDecoration(color: Color(0xff22C55E), shape: BoxShape.circle)),
                      SizedBox(width: 4.w),
                      Text("Running", style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, color: const Color(0xff22C55E))),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: Colors.grey.shade100, height: 1),
            SizedBox(height: 10.h),
            Row(
              children: [
                _betDetail("Amount", "₹${item['amount']}"),
                _betDetail("Market", item['game'].toString().split(' ').first),
                _betDetail("Time", item['time']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _betDetail(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade500)),
          SizedBox(height: 3.h),
          Text(value, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
      ),
    );
  }
}
