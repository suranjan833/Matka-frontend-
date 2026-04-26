import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/result_page_controller.dart';

class ResultPageView extends GetView<ResultPageController> {
  const ResultPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF7B61FF);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Results"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            /// Dropdown
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(6.r),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: "KOLKATA FATAFAT",
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.purple),
                  items: ["KOLKATA FATAFAT", "MUMBAI FATAFAT", "DELHI FATAFAT"]
                      .map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      })
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ),

            SizedBox(height: 15.h),

            /// Result List
            Column(
              children: [
                _resultCard(primaryColor, "14-04-2026", [
                  ["4", "130"],
                  ["3", "139"],
                  ["0", "569"],
                  ["0", "569"],
                  ["3", "256"],
                  ["7", "458"],
                  ["0", "118"],
                  ["9", "360"],
                ]),
                _resultCard(primaryColor, "13-04-2026", [
                  ["7", "269"],
                  ["2", "679"],
                  ["9", "568"],
                  ["3", "157"],
                  ["8", "990"],
                  ["2", "390"],
                  ["2", "499"],
                  ["4", "158"],
                ]),
                _resultCard(primaryColor, "12-04-2026", [
                  ["7", "278"],
                  ["4", "239"],
                  ["0", "145"],
                  ["7", "566"],
                  ["-", "-"],
                  ["-", "-"],
                  ["-", "-"],
                  ["-", "-"],
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Result Card
  Widget _resultCard(Color primaryColor, String date, List<List<String>> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              Text(
                "KOLKATA FATAFAT",
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              const Spacer(),
              const Icon(Icons.calendar_month, size: 18, color: Colors.purple),
              SizedBox(width: 5.w),
              Text(date, style: TextStyle(color: Colors.purple)),
            ],
          ),

          SizedBox(height: 8.h),

          Divider(color: Colors.purple),

          SizedBox(height: 8.h),

          /// Numbers Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data.map((item) {
                return Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 1.5),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      Text(item[0], style: TextStyle(fontSize: 16.sp)),
                      SizedBox(height: 4.h),
                      Text(item[1], style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
