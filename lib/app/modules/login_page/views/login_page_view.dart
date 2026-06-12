import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matka/app/modules/sign_up/views/sign_up_view.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({super.key});

  static const primaryColor = Color(0xFF7B61FF);
  static const primaryLight = Color(0xFF9C8CFF);
  static const primaryDark = Color(0xFF5A3FD4);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoginPageController());

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
                        Icons.casino_rounded,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Login to continue playing",
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
                      /// Phone Field
                      _buildInputField(
                        controller: c.emailController,
                        hint: "Phone Number",
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                      ),
                      SizedBox(height: 16.h),

                      /// Password Field
                      Obx(
                        () => _buildInputField(
                          controller: c.passwordController,
                          hint: "Password",
                          icon: Icons.lock_outlined,
                          obscureText: !c.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              c.isPasswordVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey.shade400,
                              size: 20.sp,
                            ),
                            onPressed: c.togglePasswordVisibility,
                          ),
                        ),
                      ),

                      SizedBox(height: 4.h),

                      /// Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                          ),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      /// Login Button
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
                            onPressed: c.isLoading.value
                                ? null
                                : () => c.login(),
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
                                child: c.isLoading.value
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Text(
                                        "Login",
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

              /// ─── OR DIVIDER ─────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade200)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade200)),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              /// ─── SIGN UP LINK ───────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const SignUpView()),
                    child: Text(
                      "Sign Up",
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
    int? maxLength,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        final hasFocus = FocusScope.of(context).hasFocus &&
            controller.text.isNotEmpty;

        return TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
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
