import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/withdraw_page_controller.dart';

class WithdrawPageView extends GetView<WithdrawPageController> {
  const WithdrawPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF7B61FF);
    final controller = Get.put(WithdrawPageController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Withdraw"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Balance Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B61FF), Color(0xFF9C8CFF)],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Available Balance",
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 8.h),
                  const Text(
                    "₹ 0",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            /// Amount
            Text("Enter Withdraw Amount", style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 8.h),

            TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount",
                prefixIcon: const Icon(Icons.currency_rupee),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 15.h),

            /// Quick Amount
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [100, 500, 1000, 2000].map((amount) {
                return GestureDetector(
                  onTap: () => controller.setAmount(amount),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      "₹$amount",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 25.h),

            Text("Withdraw To", style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 10.h),

            _input("Name", Icons.person, controller.nameController),
            _input(
              "Bank Name",
              Icons.account_balance,
              controller.bankController,
            ),
            _input(
              "Account Number",
              Icons.numbers,
              controller.accountController,
            ),
            _input("IFSC Code", Icons.code, controller.ifscController),
            _input(
              "UPI ID (optional)",
              Icons.qr_code,
              controller.upiController,
            ),

            SizedBox(height: 30.h),

            /// Button
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitWithdraw,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Request Withdraw",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, IconData icon, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
