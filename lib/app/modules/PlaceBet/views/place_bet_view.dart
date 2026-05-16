/// place_bet_view.dart

library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/place_bet_controller.dart';

class PlaceBetView extends GetView<PlaceBetController> {
  const PlaceBetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlaceBetController());

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.gameType['name']),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 Bazaar Name
            Text(
              controller.bazaar['name'],
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10.h),

            /// 🔥 Time Left
            Obx(
              () => Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),

                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(15.r),
                ),

                child: Column(
                  children: [
                    Text(
                      "Time Left",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Text(
                      controller.timeLeft.value,
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25.h),

            /// 🔥 Number Field
            Text(
              "Enter Number",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 10.h),

            TextField(
              controller: controller.numberController,
              keyboardType: TextInputType.number,
              maxLength: controller.gameType['digits'],

              decoration: InputDecoration(
                hintText: "Enter ${controller.gameType['digits']} digit number",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            /// 🔥 Amount Field
            Text(
              "Enter Amount",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 10.h),

            TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                hintText: "Enter Amount",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),

            SizedBox(height: 35.h),

            /// 🔥 BUTTON
            SizedBox(
              width: double.infinity,

              height: 55.h,

              child: ElevatedButton(
                onPressed: controller.placeBet,

                child: Text(
                  "PLACE BET",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
