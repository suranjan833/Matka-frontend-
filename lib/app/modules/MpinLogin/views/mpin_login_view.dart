import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/mpin_login_controller.dart';

class MpinLoginView extends GetView<MpinLoginController> {
  const MpinLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MpinLoginController());

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MPIN LOGIN",
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff1673E6),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Login with your MPIN",
                        style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                      ),
                    ],
                  ),

                  Icon(Icons.lock_outline, size: 48.sp, color: Color(0xff1673E6)),
                ],
              ),

              SizedBox(height: 60.h),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 20.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      width: 50.w,
                      child: TextField(
                        controller: controller.pinControllers[index],
                        focusNode: controller.focusNodes[index],
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          counterText: "",
                          enabledBorder: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(),
                        ),
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) =>
                            controller.onPinChanged(value, index),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.FORGOT_MPIN);
                    },
                    child: Text(
                      "Forgot MPIN?",
                      style: TextStyle(fontSize: 14.sp, color: Colors.red.shade400),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.SET_MPIN);
                    },
                    child: Text(
                      "Set / Change",
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1565C0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      elevation: 6,
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "MPIN LOGIN",
                            style: TextStyle(
                              fontSize: 16.sp,
                              letterSpacing: 2,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),

              const Spacer(),

              Center(
                child: Text(
                  "OR",
                  style: TextStyle(fontSize: 16.sp, color: Colors.blueGrey),
                ),
              ),

              SizedBox(height: 30.h),

              Center(
                child: InkWell(
                  onTap: controller.biometricLogin,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.fingerprint,
                          size: 42.sp,
                          color: Color(0xff1673E6),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          "Unlock with Biometric",
                          style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
