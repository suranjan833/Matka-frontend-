import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/add_money_controller.dart';

class AddMoneyView extends GetView<AddMoneyController> {
  const AddMoneyView({super.key});

  static const primaryColor = Color(0xFF7B61FF);
  static const primaryLight = Color(0xFF9C8CFF);
  static const primaryDark = Color(0xFF5A3FD4);

  // ── Payment brand colors ──────────────────────────────────────────────
  static const _upiColor = Color(0xFF7B61FF);
  static const _paytmColor = Color(0xFF00BAF2);
  static const _gpayColor = Color(0xFF4285F4);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoneyController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildBalanceCard(controller),
                    SizedBox(height: 20.h),
                    _buildAmountForm(controller),
                    SizedBox(height: 20.h),
                    _buildPaymentMethods(controller),
                    SizedBox(height: 24.h),
                    _buildSubmitButton(controller),
                    SizedBox(height: 16.h),
                    _buildTimer(controller),
                    SizedBox(height: 20.h),
                    _buildRecentHistory(),
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
  Widget _buildHeader() {
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
                "Add Money",
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
  Widget _buildBalanceCard(AddMoneyController controller) {
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
                    "Wallet Balance",
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
                    Icon(Icons.add_rounded, color: Colors.white, size: 16.sp),
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
  Widget _buildAmountForm(AddMoneyController controller) {
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
                "Enter Amount",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            "Choose or type the amount you want to add",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
          ),
          SizedBox(height: 14.h),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                color: controller.isTimerActive.value ? Colors.grey.shade100 : const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: controller.amountController,
                enabled: !controller.isTimerActive.value,
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
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: primaryColor.withValues(alpha: .4), width: 1.5)),
                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
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
          Obx(
            () => Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [100, 200, 500, 1000, 2000, 5000].map((amount) {
                final isSelected = controller.selectedAmount.value == amount;
                final disabled = controller.isTimerActive.value;
                return GestureDetector(
                  onTap: disabled ? null : () => controller.setAmount(amount),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
                    decoration: BoxDecoration(
                      color: disabled
                          ? Colors.grey.shade100
                          : isSelected
                              ? primaryColor.withValues(alpha: .1)
                              : const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: isSelected && !disabled
                            ? primaryColor.withValues(alpha: .4)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      "₹$amount",
                      style: TextStyle(
                        color: disabled
                            ? Colors.grey.shade300
                            : isSelected
                                ? primaryColor
                                : Colors.grey.shade600,
                        fontSize: 13.sp,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  PAYMENT METHODS
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildPaymentMethods(AddMoneyController controller) {
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
                child: Icon(Icons.payments_outlined, color: primaryColor, size: 16.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                "Payment Method",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _brandPaymentTile(
            controller: controller,
            title: "UPI",
            subtitle: "Any UPI app",
            color: _upiColor,
            icon: Icons.account_balance_rounded,
            lightBg: _upiColor.withValues(alpha: .08),
          ),
          SizedBox(height: 10.h),
          _brandPaymentTile(
            controller: controller,
            title: "Paytm",
            subtitle: "Paytm Wallet / UPI",
            color: _paytmColor,
            icon: Icons.wallet_rounded,
            lightBg: _paytmColor.withValues(alpha: .08),
          ),
          SizedBox(height: 10.h),
          _brandPaymentTile(
            controller: controller,
            title: "Google Pay",
            subtitle: "GPay UPI",
            color: _gpayColor,
            icon: Icons.payment_rounded,
            lightBg: _gpayColor.withValues(alpha: .08),
          ),
        ],
      ),
    );
  }

  Widget _brandPaymentTile({
    required AddMoneyController controller,
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required Color lightBg,
  }) {
    return Obx(() {
      final isSelected = controller.selectedPayment.value == title;
      final disabled = controller.isTimerActive.value;
      return GestureDetector(
        onTap: disabled ? null : () => controller.selectPayment(title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected && !disabled ? lightBg : const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isSelected && !disabled ? color.withValues(alpha: .3) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: isSelected && !disabled ? color.withValues(alpha: .12) : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected && !disabled ? color.withValues(alpha: .15) : Colors.grey.shade200,
                  ),
                ),
                child: Icon(icon, color: disabled ? Colors.grey.shade300 : color, size: 20.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: disabled ? Colors.grey.shade300 : Colors.black87,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              if (!disabled)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isSelected
                      ? Container(
                          key: const ValueKey("checked"),
                          height: 24.h,
                          width: 24.h,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                        )
                      : Container(
                          key: const ValueKey("unchecked"),
                          height: 24.h,
                          width: 24.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300, width: 2),
                          ),
                        ),
                ),
            ],
          ),
        ),
      );
    });
  }

  // ═════════════════════════════════════════════════════════════════════
  //  SUBMIT BUTTON & PAYMENT MODAL
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildSubmitButton(AddMoneyController controller) {
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
            onPressed: controller.isTimerActive.value
                ? null
                : () => _showPaymentSheet(controller),
            child: Ink(
              decoration: BoxDecoration(
                gradient: controller.isTimerActive.value
                    ? LinearGradient(colors: [Colors.grey.shade300, Colors.grey.shade400])
                    : const LinearGradient(colors: [primaryColor, primaryLight]),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: controller.isTimerActive.value
                    ? []
                    : [BoxShadow(color: primaryColor.withValues(alpha: .4), blurRadius: 16, offset: const Offset(0, 6))],
              ),
              child: Center(
                child: controller.isLoading.value
                    ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            controller.isTimerActive.value ? Icons.hourglass_empty_rounded : Icons.flash_on_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            controller.isTimerActive.value ? "WAITING..." : "Continue to Pay",
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

  void _showPaymentSheet(AddMoneyController controller) {
    if (controller.amountController.text.isEmpty) {
      Get.snackbar("Amount Required", "Please enter an amount to add");
      return;
    }
    if (controller.selectedPayment.value.isEmpty) {
      Get.snackbar("Payment Method Required", "Please select a payment method");
      return;
    }

    controller.selectedImage.value = null;
    controller.transactionIdController.clear();

    Get.bottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28.r))),
      Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              height: 4.h,
              width: 40.w,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(height: 20.h),

            // Title
            Row(
              children: [
                Container(
                  height: 36.h,
                  width: 36.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Icon(Icons.verified_rounded, color: Color(0xFF4CAF50), size: 20),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Proof",
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "₹${controller.amountController.text} via ${controller.selectedPayment.value}",
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 32.h,
                    width: 32.h,
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(Icons.close_rounded, color: Colors.grey.shade600, size: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Payment details preview
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount", style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp)),
                      Text(
                        "₹${controller.amountController.text}",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp, color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Divider(color: Colors.grey.shade200, height: 1),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Method", style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp)),
                      Text(
                        controller.selectedPayment.value,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Transaction ID
            TextField(
              controller: controller.transactionIdController,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              decoration: InputDecoration(
                hintText: "Enter Transaction ID",
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
                prefixIcon: Icon(Icons.receipt_outlined, color: Colors.grey.shade400, size: 20.sp),
                filled: true,
                fillColor: const Color(0xFFF5F7FA),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: primaryColor.withValues(alpha: .5), width: 1.5),
                ),
              ),
            ),
            SizedBox(height: 14.h),

            // Upload screenshot
            Obx(
              () => GestureDetector(
                onTap: controller.isPickingImage.value ? null : controller.pickImage,
                child: Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: Colors.grey.shade200, style: BorderStyle.solid),
                  ),
                  child: controller.isPickingImage.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.selectedImage.value == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined, color: primaryColor, size: 28.sp),
                                SizedBox(height: 6.h),
                                Text(
                                  "Upload Screenshot",
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Show payment confirmation",
                                  style: TextStyle(color: Colors.grey.shade400, fontSize: 11.sp),
                                ),
                              ],
                            )
                          : Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14.r),
                                  child: Image.file(controller.selectedImage.value!, fit: BoxFit.cover),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                    child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                ),
                onPressed: () async {
                  await controller.submitPayment();
                  if (controller.isTimerActive.value) {
                    // Don't close — timer is running, keep sheet open
                  } else {
                    Get.back();
                  }
                },
                child: Text(
                  "Submit Payment",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  TIMER
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildTimer(AddMoneyController controller) {
    return Obx(() {
      if (!controller.isTimerActive.value) return const SizedBox();
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                value: controller.remainingSeconds.value / 600,
                strokeWidth: 2.5,
                color: Colors.orange.shade600,
                backgroundColor: Colors.orange.shade200,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              "Waiting for verification: ${controller.timeText}",
              style: TextStyle(
                color: Colors.orange.shade800,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      );
    });
  }

  // ═════════════════════════════════════════════════════════════════════
  //  RECENT HISTORY
  // ═════════════════════════════════════════════════════════════════════
  Widget _buildRecentHistory() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 4.h),
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
                child: Icon(Icons.history_rounded, color: primaryColor, size: 16.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const Spacer(),
              Text(
                "View All",
                style: TextStyle(fontSize: 12.sp, color: primaryColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.chevron_right_rounded, color: primaryColor, size: 16.sp),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.receipt_long_outlined, color: Colors.grey.shade300, size: 36.sp),
                  SizedBox(height: 8.h),
                  Text(
                    "No recent transactions",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
