import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/deposit_history_controller.dart';

class DepositHistoryView extends GetView<DepositHistoryController> {
  const DepositHistoryView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    Get.put(DepositHistoryController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 18.h),
            _buildSummaryCard(),
            SizedBox(height: 16.h),
            Expanded(child: Obx(() {
              if (controller.deposits.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history_rounded, size: 64.sp, color: Colors.grey.shade300),
                      SizedBox(height: 16.h),
                      Text("No deposit history", style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade500)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.deposits.length,
                itemBuilder: (_, index) {
                  final item = controller.deposits[index];
                  return _depositCard(item, index);
                },
              );
            })),
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
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 38.w, height: 38.w,
              decoration: BoxDecoration(color: const Color(0xffF6F8FB), borderRadius: BorderRadius.circular(11.r)),
              child: Icon(Icons.arrow_back_rounded, color: Colors.black87, size: 20.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Text("Deposit History", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    final totalDeposits = controller.deposits.fold<double>(0, (sum, item) => sum + (item['amount'] as int));
    final completed = controller.deposits.where((d) => d['status'] == 'Completed').length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xff06B6D4), Color(0xff0891B2)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: const Color(0xff06B6D4).withValues(alpha: .3), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Deposited", style: TextStyle(color: Colors.white.withValues(alpha: .8), fontSize: 12.sp)),
                SizedBox(height: 4.h),
                Text("₹${totalDeposits.toStringAsFixed(0)}", style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: .18), borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              children: [
                Text("$completed/${controller.deposits.length}", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800)),
                Text("Completed", style: TextStyle(color: Colors.white.withValues(alpha: .8), fontSize: 10.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _depositCard(Map<String, dynamic> item, int index) {
    final color = item['status'] == 'Completed'
        ? const Color(0xff22C55E)
        : item['status'] == 'Pending' ? const Color(0xffF59E0B) : const Color(0xffEF4444);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 60)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w, height: 44.w,
              decoration: BoxDecoration(color: color.withValues(alpha: .1), shape: BoxShape.circle),
              child: Icon(
                item['status'] == 'Completed' ? Icons.check_circle_rounded : item['status'] == 'Pending' ? Icons.schedule_rounded : Icons.cancel_rounded,
                color: color, size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("₹${item['amount']}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800, color: Colors.black87)),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(color: color.withValues(alpha: .1), borderRadius: BorderRadius.circular(6.r)),
                        child: Text(item['status'], style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, color: color)),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text("${item['method']} • ${item['txnId']}", style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                  SizedBox(height: 2.h),
                  Text("${item['date']} at ${item['time']}", style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
