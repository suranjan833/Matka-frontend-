import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/withdraw_funds_controller.dart';

class WithdrawFundsView extends GetView<WithdrawFundsController> {
  const WithdrawFundsView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    Get.put(WithdrawFundsController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 18.h),
              _buildBalanceCard(),
              SizedBox(height: 16.h),
              _buildAmountCard(),
              SizedBox(height: 16.h),
              _buildBankSelector(),
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
          Text("Withdraw Funds", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xff0EA5E9), Color(0xff0284C7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: const Color(0xff0EA5E9).withValues(alpha: .3), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w, height: 48.w,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: .18), shape: BoxShape.circle),
            child: Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Available Balance", style: TextStyle(color: Colors.white.withValues(alpha: .8), fontSize: 12.sp)),
              SizedBox(height: 2.h),
              Text("₹0.00", style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w800)),
            ],
          ),
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
          Text("Withdrawal Amount", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
          SizedBox(height: 8.h),
          TextField(
            controller: controller.amountController,
            onChanged: controller.onAmountChanged,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800, color: Colors.black87),
            decoration: InputDecoration(
              prefixText: '₹ ', prefixStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800, color: primaryColor),
              hintText: '0', hintStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800, color: Colors.grey.shade300),
              border: InputBorder.none, filled: true, fillColor: const Color(0xffF5F7FA),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            ),
          ),
          SizedBox(height: 12.h),
          Text("Minimum withdrawal: ₹500", style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500)),
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

  Widget _buildBankSelector() {
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
          Row(
            children: [
              Text("Bank Account", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
              const Spacer(),
              Text("+ Add New", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: primaryColor)),
            ],
          ),
          SizedBox(height: 14.h),
          Obx(() => Column(
            children: List.generate(controller.savedBanks.length, (index) {
              final bank = controller.savedBanks[index];
              final isSelected = controller.selectedBankIndex.value == index;
              return GestureDetector(
                onTap: () => controller.selectBank(index),
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withValues(alpha: .06) : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: isSelected ? primaryColor : Colors.grey.shade200, width: isSelected ? 1.5.w : 1.w),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44.w, height: 44.w,
                        decoration: BoxDecoration(color: primaryColor.withValues(alpha: .1), shape: BoxShape.circle),
                        child: Icon(Icons.account_balance_rounded, color: primaryColor, size: 22.sp),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bank['holder'], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
                            SizedBox(height: 2.h),
                            Text("${bank['name']} • ${bank['account']}", style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      if (isSelected) Icon(Icons.check_circle_rounded, color: primaryColor, size: 22.sp),
                    ],
                  ),
                ),
              );
            }),
          )),
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
          onPressed: controller.submitWithdraw,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.send_rounded, size: 20.sp),
              SizedBox(width: 8.w),
              Text("Withdraw Now", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}
