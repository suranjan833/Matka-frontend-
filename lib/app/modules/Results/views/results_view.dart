import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/results_controller.dart';

class ResultsView extends GetView<ResultsController> {
  const ResultsView({super.key});

  static const primaryColor = Color(0xff1673E6);
  static const bgColor = Color(0xffF5F7FA);

  @override
  Widget build(BuildContext context) {
    Get.put(ResultsController());

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 18.h),
            Expanded(
              child: Obx(() {
                if (controller.results.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emoji_events_outlined, size: 64.sp, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        Text("No results available", style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade500)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.results.length,
                  itemBuilder: (_, index) => _resultCard(controller.results[index], index),
                );
              }),
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
              gradient: const LinearGradient(colors: [Color(0xff22C55E), Color(0xff16A34A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [BoxShadow(color: const Color(0xff22C55E).withValues(alpha: .2), blurRadius: 8, offset: const Offset(0, 3))],
            ),
            child: Icon(Icons.emoji_events_rounded, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Text("Results", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _resultCard(Map<String, dynamic> item, int index) {
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
              decoration: BoxDecoration(color: primaryColor.withValues(alpha: .1), borderRadius: BorderRadius.circular(12.r)),
              child: Icon(Icons.sports_kabaddi_rounded, color: primaryColor, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['game'], style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                  SizedBox(height: 4.h),
                  Text(item['date'], style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500)),
                ],
              ),
            ),
            _resultDigit("Open", item['open'], const Color(0xff22C55E)),
            SizedBox(width: 10.w),
            _resultDigit("Close", item['close'], const Color(0xffEF4444)),
          ],
        ),
      ),
    );
  }

  Widget _resultDigit(String label, String digit, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade500)),
        SizedBox(height: 4.h),
        Container(
          width: 36.w, height: 36.w,
          decoration: BoxDecoration(color: color.withValues(alpha: .12), shape: BoxShape.circle),
          child: Center(child: Text(digit, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: color))),
        ),
      ],
    );
  }
}
