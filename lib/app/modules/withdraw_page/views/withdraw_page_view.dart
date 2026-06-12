import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/withdraw_page_controller.dart';

class WithdrawPageView extends GetView<WithdrawPageController> {
  const WithdrawPageView({super.key});

  static const primaryColor = Color(0xFF7B61FF);
  static const primaryLight = Color(0xFF9C8CFF);
  static const primaryDark = Color(0xFF5A3FD4);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WithdrawPageController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(controller),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildBalanceCard(controller),
                    SizedBox(height: 20.h),
                    _buildAmountForm(controller),
                    SizedBox(height: 20.h),
                    _buildBankDetails(controller),
                    SizedBox(height: 20.h),
                    _buildUpiSection(controller),
                    SizedBox(height: 24.h),
                    _buildSummaryCard(controller),
                    SizedBox(height: 20.h),
                    _buildSubmitButton(controller),
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

  // ═════════════════════════════════════════════════════════════════════
  //  HEADER
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildHeader(WithdrawPageController _) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryDark],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28.r),
          bottomRight: Radius.circular(28.r),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: .35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 36.h,
                  width: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Withdraw",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  BALANCE CARD
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildBalanceCard(WithdrawPageController controller) {
    return Container(
        margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor.withValues(alpha: .9), primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: .3),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 52.h,
              width: 52.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .18),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 26),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available for Withdraw",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .8),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "₹ 0.00",
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 36.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swap_vert_rounded, color: Colors.white, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "History",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  AMOUNT FORM
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildAmountForm(WithdrawPageController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 28.h,
                width: 28.h,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.monetization_on_outlined, color: primaryColor, size: 16.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                "Withdraw Amount",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            "Minimum withdrawal: ₹100",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
          ),
          SizedBox(height: 14.h),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 22.sp, color: Colors.black87, fontWeight: FontWeight.w700, letterSpacing: 0.5),
              decoration: InputDecoration(
                counterText: "",
                hintText: "0",
                hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 22.sp, fontWeight: FontWeight.w700),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 8.w),
                  child: Text(
                    "₹",
                    style: TextStyle(fontSize: 22.sp, color: Colors.black54, fontWeight: FontWeight.w700),
                  ),
                ),
                filled: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: primaryColor.withValues(alpha: .4), width: 1.5),
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          /// Quick Amount Chips
          Text(
            "Quick Select",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10.h),
          Obx(() => Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [100, 200, 500, 1000, 2000, 5000].map((amount) {
              final isSelected = controller.selectedAmount.value == amount;
              return GestureDetector(
                onTap: () => controller.setAmount(amount),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withValues(alpha: .1) : const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isSelected ? primaryColor.withValues(alpha: .4) : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    "₹$amount",
                    style: TextStyle(
                      color: isSelected ? primaryColor : Colors.grey.shade600,
                      fontSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  BANK DETAILS SECTION
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildBankDetails(WithdrawPageController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 28.h,
                width: 28.h,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.account_balance_outlined, color: primaryColor, size: 16.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                "Bank Account Details",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            "Enter your bank information for withdrawal",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
          ),
          SizedBox(height: 18.h),

          _buildField(
            controller: controller.nameController,
            hint: "Full Name (as per bank)",
            icon: Icons.person_outline_rounded,
          ),
          SizedBox(height: 14.h),

          _buildField(
            controller: controller.bankController,
            hint: "Bank Name",
            icon: Icons.account_balance_rounded,
          ),
          SizedBox(height: 14.h),

          _buildField(
            controller: controller.accountController,
            hint: "Account Number",
            icon: Icons.numbers_rounded,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 14.h),

          _buildField(
            controller: controller.ifscController,
            hint: "IFSC Code",
            icon: Icons.code_rounded,
            helperText: "e.g. SBIN0001234",
          ),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  UPI SECTION
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildUpiSection(WithdrawPageController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 28.h,
                width: 28.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9).withValues(alpha: .6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.qr_code_rounded, color: const Color(0xFF4CAF50), size: 16.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                "UPI Details",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "Optional",
                  style: TextStyle(fontSize: 10.sp, color: Colors.orange.shade700, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            "Add UPI ID for faster withdrawal (skip if using bank)",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
          ),
          SizedBox(height: 14.h),
          _buildField(
            controller: controller.upiController,
            hint: "UPI ID (e.g. name@upi)",
            icon: Icons.alternate_email_rounded,
          ),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  FIELD BUILDER
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? helperText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
              prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20.sp),
              filled: false,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.r), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.r), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: primaryColor.withValues(alpha: .5), width: 1.5),
              ),
            ),
          ),
        ),
        if (helperText != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 4.w),
            child: Text(
              helperText,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 11.sp),
            ),
          ),
      ],
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  SUMMARY CARD
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildSummaryCard(WithdrawPageController controller) {
    return Obx(() {
      if (!controller.hasAmount.value || !controller.hasBankOrUpi.value) return const SizedBox();

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 24.h,
                  width: 24.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: const Icon(Icons.description_rounded, color: Color(0xFF4CAF50), size: 14),
                ),
                SizedBox(width: 8.w),
                Text(
                  "Withdrawal Summary",
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _summaryRow("Amount", "₹${controller.amountController.text}"),
                  SizedBox(height: 8.h),
                  Divider(color: Colors.grey.shade100, height: 1),
                  SizedBox(height: 8.h),
                  _summaryRow(
                    "Transfer To",
                    controller.accountController.text.isNotEmpty
                        ? "Bank (${controller.accountController.text.substring(0, controller.accountController.text.length > 4 ? controller.accountController.text.length - 4 : controller.accountController.text.length)}XXXX)"
                        : "UPI: ${controller.upiController.text}",
                  ),
                  SizedBox(height: 8.h),
                  Divider(color: Colors.grey.shade100, height: 1),
                  SizedBox(height: 8.h),
                  _summaryRow("Processing Time", "24-48 hours"),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp)),
        Flexible(
          child: Text(
            value,
            style: TextStyle(color: Colors.black87, fontSize: 12.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  SUBMIT BUTTON
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildSubmitButton(WithdrawPageController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        height: 54.h,
        child: Obx(
          () => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              padding: EdgeInsets.zero,
            ),
            onPressed: controller.isLoading.value ? null : controller.submitWithdraw,
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [primaryColor, primaryLight]),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [BoxShadow(color: primaryColor.withValues(alpha: .4), blurRadius: 16, offset: const Offset(0, 6))],
              ),
              child: Center(
                child: controller.isLoading.value
                    ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_circle_up_rounded, color: Colors.white, size: 22),
                          SizedBox(width: 8.w),
                          Text(
                            "Request Withdraw",
                            style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
