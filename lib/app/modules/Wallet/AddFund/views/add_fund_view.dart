import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/add_fund_controller.dart';

class AddFundView extends GetView<AddFundController> {
  const AddFundView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    Get.put(AddFundController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 18.h),
              _buildAmountCard(),
              SizedBox(height: 16.h),
              _buildUpiSection(),
              SizedBox(height: 24.h),
              _buildPaymentDoneButton(),
              SizedBox(height: 32.h),
            ],
          ),
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
          BoxShadow(color: Colors.black.withValues(alpha: .03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
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
          Text("Add Fund", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter Amount", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
          SizedBox(height: 8.h),
          TextField(
            controller: controller.amountController,
            onChanged: controller.onAmountChanged,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800, color: Colors.black87),
            decoration: InputDecoration(
              prefixText: '₹ ',
              prefixStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800, color: primaryColor),
              hintText: '0',
              hintStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800, color: Colors.grey.shade300),
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xffF5F7FA),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            ),
          ),
          SizedBox(height: 16.h),

          /// Quick amount chips with proper gapping
          Row(
            children: [
              _quickChip('100'),
              SizedBox(width: 10.w),
              _quickChip('500'),
              SizedBox(width: 10.w),
              _quickChip('1000'),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              _quickChip('2000'),
              SizedBox(width: 10.w),
              _quickChip('5000'),
            ],
          ),

          Obx(() {
            if (controller.errorMessage.value.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(controller.errorMessage.value, style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600, fontWeight: FontWeight.w500)),
            );
          }),
        ],
      ),
    );
  }

  Widget _quickChip(String amount) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.amountController.text = amount;
          controller.onAmountChanged(amount);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: primaryColor.withValues(alpha: .2)),
          ),
          child: Center(
            child: Text('₹$amount', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: primaryColor)),
          ),
        ),
      ),
    );
  }

  Widget _buildUpiSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w, height: 40.w,
                decoration: BoxDecoration(color: const Color(0xff8B5CF6).withValues(alpha: .12), shape: BoxShape.circle),
                child: Icon(Icons.qr_code_rounded, color: const Color(0xff8B5CF6), size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Text("Pay via UPI", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
            ],
          ),
          SizedBox(height: 20.h),

          // QR Code placeholder
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200, width: 2.w),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_2_rounded, size: 80.sp, color: Colors.black87),
                  SizedBox(height: 6.h),
                  Text("Scan to Pay", style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // UPI details
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xffF5F7FA),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _upiDetailRow("UPI ID", controller.upiId),
                SizedBox(height: 8.h),
                _upiDetailRow("Name", controller.upiName),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _upiDetailRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
        const Spacer(),
        Text(value, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: () {},
          child: Icon(Icons.copy_rounded, size: 16.sp, color: primaryColor),
        ),
      ],
    );
  }

  Widget _buildPaymentDoneButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity, height: 52.h,
        child: ElevatedButton.icon(
          onPressed: controller.showPaymentDialog,
          icon: Icon(Icons.check_circle_outline, size: 20.sp),
          label: Text("Payment Done", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff22C55E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
            elevation: 0,
            shadowColor: const Color(0xff22C55E).withValues(alpha: .3),
          ),
        ),
      ),
    );
  }
}
