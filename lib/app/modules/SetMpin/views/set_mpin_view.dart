import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/set_mpin_controller.dart';

class SetMpinView extends GetView<SetMpinController> {
  const SetMpinView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    Get.put(SetMpinController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard(),
                    SizedBox(height: 20.h),
                    _buildPasswordSection(),
                    SizedBox(height: 20.h),
                    _buildNewMpinSection(),
                    SizedBox(height: 20.h),
                    _buildConfirmMpinSection(),
                    SizedBox(height: 16.h),
                    _buildErrorMessage(),
                    SizedBox(height: 16.h),
                    _buildSubmitButton(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
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
            onTap: () => Get.back(),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set MPIN",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Text(
                "Create a 4-digit quick login PIN",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Icon(
              Icons.lock_outline,
              color: primaryColor,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1673E6), Color(0xff0B5ED7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: .25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_rounded,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Access",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Use MPIN to login faster without entering your password each time.",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .8),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, size: 16.sp, color: primaryColor),
              SizedBox(width: 8.w),
              Text(
                "Verify Password",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(
            () => TextField(
              controller: controller.passwordController,
              obscureText: !controller.isPasswordVisible.value,
              style: TextStyle(fontSize: 15.sp, color: Colors.black87),
              decoration: InputDecoration(
                hintText: "Enter your account password",
                hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
                filled: true,
                fillColor: const Color(0xffF5F7FA),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: primaryColor, width: 1.5.w),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey.shade400,
                    size: 20.sp,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewMpinSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pin_outlined, size: 16.sp, color: primaryColor),
              SizedBox(width: 8.w),
              Text(
                "New MPIN",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xffF59E0B).withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  "4 digits",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffF59E0B),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => SizedBox(
                width: 56.w,
                height: 60.h,
                child: TextField(
                  controller: controller.newPinControllers[index],
                  focusNode: controller.pinFocusNodes[index],
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmMpinSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.replay_rounded, size: 16.sp, color: primaryColor),
              SizedBox(width: 8.w),
              Text(
                "Confirm MPIN",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => SizedBox(
                width: 56.w,
                height: 60.h,
                child: TextField(
                  controller: controller.confirmPinControllers[index],
                  focusNode: controller.confirmPinFocusNodes[index],
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Obx(() {
      if (controller.errorMessage.value.isEmpty) {
        return const SizedBox.shrink();
      }
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
                style: TextStyle(
                  color: const Color(0xffDC2626),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: Obx(
        () => ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.setMpin,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: controller.isLoading.value
              ? SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      "Set MPIN",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
