import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  static const primaryColor = Color(0xFF7B61FF);
  static const primaryLight = Color(0xFF9C8CFF);
  static const primaryDark = Color(0xFF5A3FD4);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /// ─── GRADIENT HEADER ────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 50.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryColor, primaryDark],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: .4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// App icon badge
                    Container(
                      height: 56.h,
                      width: 56.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .18),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.person_add_rounded,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Sign up to get started",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .8),
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),

              /// ─── FORM CARD ──────────────────────────────────────────────
              Transform.translate(
                offset: Offset(0, -24.h),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .06),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// Full Name
                      _buildInputField(
                        controller: controller.nameController,
                        hint: "Full Name",
                        icon: Icons.person_outlined,
                      ),
                      SizedBox(height: 16.h),

                      /// Phone Number
                      _buildInputField(
                        controller: controller.phoneController,
                        hint: "Phone Number",
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 16.h),

                      /// Email Address
                      _buildInputField(
                        controller: controller.emailController,
                        hint: "Email Address",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.h),

                      /// Password
                      Obx(
                        () => _buildInputField(
                          controller: controller.passwordController,
                          hint: "Password",
                          icon: Icons.lock_outlined,
                          obscureText: !controller.isPasswordVisible.value,
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
                      SizedBox(height: 16.h),

                      /// Confirm Password
                      Obx(
                        () => _buildInputField(
                          controller: controller.confirmPasswordController,
                          hint: "Confirm Password",
                          icon: Icons.lock_outline,
                          obscureText:
                              !controller.isConfirmPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey.shade400,
                              size: 20.sp,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      /// Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: controller.isLoading.value
                                ? null
                                : () => controller.signUp(),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [primaryColor, primaryLight],
                                ),
                                borderRadius: BorderRadius.circular(14.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withValues(alpha: .4),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              /// ─── LOGIN LINK ─────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        return TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: (_) => setLocalState(() {}),
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            counterText: "",
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15.sp,
            ),
            prefixIcon: Icon(
              icon,
              color: controller.text.isNotEmpty
                  ? primaryColor
                  : Colors.grey.shade400,
              size: 22.sp,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: const Color(0xFFF5F7FA),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
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
              borderSide: BorderSide(
                color: primaryColor.withValues(alpha: .5),
                width: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }
}
