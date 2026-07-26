import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/forgot_mpin_controller.dart';

class ForgotMpinView extends GetView<ForgotMpinController> {
  const ForgotMpinView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotMpinController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  switch (controller.currentStep.value) {
                    case 0:
                      return _buildPhoneStep();
                    case 1:
                      return _buildOtpStep();
                    case 2:
                      return _buildNewMpinStep();
                    default:
                      return _buildPhoneStep();
                  }
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
          GestureDetector(
            onTap: controller.goBack,
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: const Color(0xffF6F8FB),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black87,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Obx(() {
            final titles = ['Forgot MPIN', 'Verify OTP', 'Set New MPIN'];
            final subtitles = [
              'Enter your registered phone number',
              'Enter the verification code sent',
              'Create a new 4-digit MPIN',
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[controller.currentStep.value],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitles[controller.currentStep.value],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            );
          }),
          const Spacer(),
          Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Step ${controller.currentStep.value + 1}/3',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── STEP 0: Phone Entry ───────────────────────────────────
  Widget _buildPhoneStep() {
    return Column(
      children: [
        SizedBox(height: 40.h),
        // Icon
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: .1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.phone_iphone_rounded, color: primaryColor, size: 36.sp),
        ),
        SizedBox(height: 24.h),
        Text(
          'Enter your phone number',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        SizedBox(height: 8.h),
        Text(
          'We\'ll send a verification code to reset your MPIN',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
        ),
        SizedBox(height: 32.h),
        // Phone field
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black87),
                decoration: InputDecoration(
                  prefixText: '+91 ',
                  prefixStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: primaryColor),
                  counterText: '',
                  hintText: '9876543210',
                  hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey.shade300),
                  filled: true,
                  fillColor: const Color(0xffF5F7FA),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: primaryColor, width: 1.5.w),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        _buildErrorMessage(),
        SizedBox(height: 16.h),
        _buildPrimaryButton(
          label: 'Send OTP',
          icon: Icons.send_rounded,
          onPressed: controller.sendOtp,
        ),
      ],
    );
  }

  // ─── STEP 1: OTP Entry ─────────────────────────────────────
  Widget _buildOtpStep() {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: const Color(0xffF59E0B).withValues(alpha: .1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.sms_rounded, color: const Color(0xffF59E0B), size: 36.sp),
        ),
        SizedBox(height: 24.h),
        Text(
          'Enter Verification Code',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        SizedBox(height: 8.h),
        Obx(() {
          return Text(
            'Code sent to +91 ${controller.phoneController.text.trim()}',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
          );
        }),
        SizedBox(height: 32.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800, color: Colors.black87, letterSpacing: 8.sp),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '------',
                  hintStyle: TextStyle(fontSize: 28.sp, color: Colors.grey.shade300, letterSpacing: 8.sp),
                  filled: true,
                  fillColor: const Color(0xffF5F7FA),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: primaryColor, width: 1.5.w),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Obx(() {
          if (controller.otpSecondsRemaining.value > 0) {
            return Text(
              'Resend code in ${controller.otpSecondsRemaining.value}s',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
            );
          }
          return GestureDetector(
            onTap: controller.resendOtp,
            child: Text(
              'Resend OTP',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: primaryColor),
            ),
          );
        }),
        SizedBox(height: 24.h),
        _buildErrorMessage(),
        SizedBox(height: 16.h),
        _buildPrimaryButton(
          label: 'Verify OTP',
          icon: Icons.verified_rounded,
          onPressed: controller.verifyOtp,
        ),
      ],
    );
  }

  // ─── STEP 2: New MPIN ──────────────────────────────────────
  Widget _buildNewMpinStep() {
    return Column(
      children: [
        SizedBox(height: 24.h),
        // New MPIN
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.pin_outlined, size: 16.sp, color: primaryColor),
                  SizedBox(width: 8.w),
                  Text('New MPIN', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xffF59E0B).withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text('4 digits', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Color(0xffF59E0B))),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => SizedBox(
                  width: 56.w,
                  height: 60.h,
                  child: TextField(
                    controller: controller.newPinControllers[index],
                    focusNode: controller.pinFocusNodes[index],
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: const Color(0xffF5F7FA),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: primaryColor, width: 1.5.w),
                      ),
                    ),
                    onChanged: (value) => controller.onNewPinChanged(value, index),
                  ),
                )),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Confirm MPIN
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.replay_rounded, size: 16.sp, color: primaryColor),
                  SizedBox(width: 8.w),
                  Text('Confirm MPIN', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => SizedBox(
                  width: 56.w,
                  height: 60.h,
                  child: TextField(
                    controller: controller.confirmPinControllers[index],
                    focusNode: controller.confirmPinFocusNodes[index],
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: const Color(0xffF5F7FA),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: primaryColor, width: 1.5.w),
                      ),
                    ),
                    onChanged: (value) => controller.onConfirmPinChanged(value, index),
                  ),
                )),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildErrorMessage(),
        SizedBox(height: 16.h),
        _buildPrimaryButton(
          label: 'Reset MPIN',
          icon: Icons.check_circle_outline,
          onPressed: controller.resetMpin,
        ),
      ],
    );
  }

  // ─── Shared Widgets ────────────────────────────────────────
  Widget _buildErrorMessage() {
    return Obx(() {
      if (controller.errorMessage.value.isEmpty) return const SizedBox.shrink();
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xffFEE2E2),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xffFCA5A5)),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline_rounded, color: const Color(0xffEF4444), size: 16.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                controller.errorMessage.value,
                style: TextStyle(color: const Color(0xffDC2626), fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPrimaryButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: Obx(() => ElevatedButton(
        onPressed: controller.isLoading.value ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
          elevation: 0,
        ),
        child: controller.isLoading.value
            ? SizedBox(width: 22.w, height: 22.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(label, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                ],
              ),
      )),
    );
  }
}
