import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/manual_deposit_controller.dart';

class ManualDepositView extends GetView<ManualDepositController> {
  const ManualDepositView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    Get.put(ManualDepositController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 18.h),
              _buildBankDetailsCard(),
              SizedBox(height: 16.h),
              _buildUploadForm(),
              SizedBox(height: 24.h),
              _buildSubmitButton(),
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
          Text("Manual Deposit", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildBankDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xffEAB308), Color(0xffCA8A04)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: const Color(0xffEAB308).withValues(alpha: .3), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w, height: 44.w,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: .18), shape: BoxShape.circle),
                child: Icon(Icons.account_balance_rounded, color: Colors.white, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bank Transfer", style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w700)),
                  Text("Make a deposit via bank transfer", style: TextStyle(color: Colors.white.withValues(alpha: .8), fontSize: 12.sp)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.white.withValues(alpha: .2), height: 1),
          SizedBox(height: 14.h),
          _detailRow("Bank Name", "HDFC Bank"),
          SizedBox(height: 8.h),
          _detailRow("Account Name", "MATKA GAMES PVT LTD"),
          SizedBox(height: 8.h),
          _detailRow("Account No.", "12345678901234"),
          SizedBox(height: 8.h),
          _detailRow("IFSC Code", "HDFC0001234"),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 100.w, child: Text(label, style: TextStyle(color: Colors.white.withValues(alpha: .7), fontSize: 12.sp))),
        Expanded(child: Text(value, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600))),
        Icon(Icons.copy_rounded, color: Colors.white.withValues(alpha: .6), size: 16.sp),
      ],
    );
  }

  Widget _buildUploadForm() {
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
          Text("Deposit Details", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
          SizedBox(height: 16.h),
          Text("Amount", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
          SizedBox(height: 6.h),
          TextField(
            controller: controller.amountController,
            onChanged: controller.onAmountChanged,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87),
            decoration: InputDecoration(
              prefixText: '₹ ', prefixStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: primaryColor),
              hintText: 'Enter amount', hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
              filled: true, fillColor: const Color(0xffF5F7FA),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: primaryColor, width: 1.5.w)),
            ),
          ),
          SizedBox(height: 14.h),
          Text("Transaction ID", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
          SizedBox(height: 6.h),
          TextField(
            controller: controller.transactionIdController,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'e.g. TXN123456789', hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
              filled: true, fillColor: const Color(0xffF5F7FA),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: primaryColor, width: 1.5.w)),
            ),
          ),
          SizedBox(height: 16.h),
          Text("Upload Payment Screenshot", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
          SizedBox(height: 8.h),
          Obx(() {
            if (controller.selectedImagePath.value.isNotEmpty) {
              return Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xff22C55E).withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: const Color(0xff22C55E).withValues(alpha: .3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: const Color(0xff22C55E), size: 24.sp),
                    SizedBox(width: 12.w),
                    Expanded(child: Text("Screenshot uploaded", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xff22C55E)))),
                    GestureDetector(
                      onTap: controller.removeImage,
                      child: Icon(Icons.close_rounded, color: Colors.grey.shade500, size: 20.sp),
                    ),
                  ],
                ),
              );
            }
            return GestureDetector(
              onTap: controller.pickImage,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32.h),
                decoration: BoxDecoration(
                  color: const Color(0xffF5F7FA),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    Icon(Icons.cloud_upload_outlined, color: Colors.grey.shade400, size: 36.sp),
                    SizedBox(height: 8.h),
                    Text("Tap to upload screenshot", style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                    SizedBox(height: 4.h),
                    Text("PNG, JPG (max 5MB)", style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400)),
                  ],
                ),
              ),
            );
          }),
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

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity, height: 52.h,
        child: ElevatedButton(
          onPressed: controller.submitDeposit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffEAB308),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.send_rounded, size: 20.sp),
              SizedBox(width: 8.w),
              Text("Submit Deposit Request", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}
