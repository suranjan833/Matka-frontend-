import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/add_money_controller.dart';

class AddMoneyView extends GetView<AddMoneyController> {
  const AddMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF7B61FF);
    final controller = Get.put(AddMoneyController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Add Money"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Balance Card
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

            /// 🔹 Amount
            Text("Enter Amount", style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 8.h),

            Obx(
              () => TextField(
                controller: controller.amountController,
                enabled: !controller.isTimerActive.value,
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
            ),

            SizedBox(height: 15.h),

            /// 🔹 Quick Amount
            Obx(
              () => Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [100, 200, 500, 1000, 2000].map((amount) {
                  return GestureDetector(
                    onTap: () => controller.setAmount(amount),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: controller.isTimerActive.value
                            ? Colors.grey.shade300
                            : primaryColor.withOpacity(.1),
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
            ),

            SizedBox(height: 25.h),

            /// 🔹 Payment Method
            Text("Select Payment Method", style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 10.h),

            Column(
              children: [
                _paymentTile("UPI", Icons.account_balance),
                _paymentTile("Paytm", Icons.wallet),
                _paymentTile("Google Pay", Icons.payment),
              ],
            ),

            SizedBox(height: 20.h),

            /// 🔥 Payment Info (QR + UPI)
            Obx(() {
              if (controller.selectedPayment.value.isEmpty) {
                return const SizedBox();
              }

              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pay using ${controller.selectedPayment.value}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    const Text("UPI ID: yourupi@okaxis"),
                    const Text("Phone: 9876543210"),

                    SizedBox(height: 15.h),

                    Center(
                      child: Image.network(
                        "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=upi://pay?pa=yourupi@okaxis",
                        height: 120.h,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    const Text(
                      "⚠️ Pay exact amount & click below after payment",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 30.h),

            /// 🔹 Button
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
                  onPressed: controller.isTimerActive.value
                      ? null
                      : controller.openPaymentDialog,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "I Have Paid",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            /// 🔹 Timer
            Obx(() {
              if (!controller.isTimerActive.value) return const SizedBox();

              return Center(
                child: Text(
                  "Waiting: ${controller.timeText}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// 🔹 Payment Tile
  Widget _paymentTile(String title, IconData icon) {
    return Obx(() {
      final isSelected = controller.selectedPayment.value == title;

      return GestureDetector(
        onTap: () => controller.selectPayment(title),
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? Colors.purple : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.deepPurple),
              SizedBox(width: 10.w),
              Text(title),
              const Spacer(),
              if (isSelected)
                const Icon(Icons.check_circle, color: Colors.purple),
            ],
          ),
        ),
      );
    });
  }
}
