import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/add_bank_details_controller.dart';

class AddBankDetailsView extends GetView<AddBankDetailsController> {
  const AddBankDetailsView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    Get.put(AddBankDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 18.h),
              _buildForm(),
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
          Text("Add Bank Details", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
          const Spacer(),
          Container(
            width: 38.w, height: 38.w,
            decoration: BoxDecoration(color: const Color(0xff9333EA).withValues(alpha: .1), borderRadius: BorderRadius.circular(11.r)),
            child: Icon(Icons.account_balance_rounded, color: const Color(0xff9333EA), size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
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
          Text("Bank Account Information", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
          SizedBox(height: 20.h),
          _buildField("Account Holder Name", "Enter full name", controller.accountHolderController, Icons.person_outline),
          SizedBox(height: 16.h),
          _buildField("Account Number", "Enter account number", controller.accountNumberController, Icons.numbers_rounded, isNumber: true),
          SizedBox(height: 16.h),
          _buildField("Confirm Account Number", "Re-enter account number", controller.confirmAccountController, Icons.numbers_rounded, isNumber: true),
          SizedBox(height: 16.h),
          _buildField("IFSC Code", "Enter IFSC code", controller.ifscController, Icons.code_rounded),
          SizedBox(height: 16.h),
          _buildField("Bank Name", "Enter bank name", controller.bankNameController, Icons.account_balance_rounded),
          SizedBox(height: 16.h),
          _buildField("UPI ID (Optional)", "Enter UPI ID", controller.upiIdController, Icons.qr_code_rounded),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xffF59E0B).withValues(alpha: .08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xffF59E0B).withValues(alpha: .2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, color: const Color(0xffF59E0B), size: 18.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "Please ensure all details are correct. Withdrawals will only be processed to verified bank accounts.",
                    style: TextStyle(fontSize: 11.sp, color: const Color(0xff92400E), height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.errorMessage.value.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(color: const Color(0xffFEE2E2), borderRadius: BorderRadius.circular(10.r), border: Border.all(color: const Color(0xffFCA5A5))),
                child: Row(
                  children: [
                    Icon(Icons.error_outline_rounded, color: const Color(0xffEF4444), size: 16.sp),
                    SizedBox(width: 8.w),
                    Expanded(child: Text(controller.errorMessage.value, style: TextStyle(fontSize: 12.sp, color: const Color(0xffDC2626), fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildField(String label, String hint, TextEditingController controller, IconData icon, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black87),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20.sp),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
            filled: true, fillColor: const Color(0xffF5F7FA),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: primaryColor, width: 1.5.w)),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity, height: 52.h,
        child: ElevatedButton(
          onPressed: controller.submitBankDetails,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff9333EA),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save_rounded, size: 20.sp),
              SizedBox(width: 8.w),
              Text("Save Bank Details", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}
