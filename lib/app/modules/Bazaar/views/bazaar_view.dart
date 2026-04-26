import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/bazaar_controller.dart';

class BazaarView extends GetView<BazaarController> {
  const BazaarView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BazaarController());

    return Scaffold(
      appBar: AppBar(title: Text(controller.categoryName), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bazaarList.isEmpty) {
          return const Center(child: Text("No Bazaar Found"));
        }

        return ListView.builder(
          padding: EdgeInsets.all(12.w),
          itemCount: controller.bazaarList.length,
          itemBuilder: (context, index) {
            final item = controller.bazaarList[index];
            return _bazaarCard(item);
          },
        );
      }),
    );
  }

  /// 🔥 BAZAAR CARD
  Widget _bazaarCard(Map<String, dynamic> item) {
    final name = item['name'] ?? '';
    final start = item['start_time'] ?? '';
    final end = item['end_time'] ?? '';
    final status = item['game_status'] ?? 'CLOSED';

    final isRunning = status.toUpperCase() == "RUNNING";

    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            name,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10.h),

          /// Start
          Row(
            children: [
              const Icon(Icons.access_time),
              SizedBox(width: 8.w),
              Text("Start Time: ${start.substring(0, 5)}"),
            ],
          ),

          SizedBox(height: 5.h),

          /// End
          Row(
            children: [
              const Icon(Icons.access_time),
              SizedBox(width: 8.w),
              Text("End Time: ${end.substring(0, 5)}"),
            ],
          ),

          SizedBox(height: 12.h),

          Divider(color: Colors.purple),

          SizedBox(height: 10.h),

          /// 🔥 BUTTON
          Center(
            child: GestureDetector(
              onTap: isRunning
                  ? () {
                      /// ✅ only when RUNNING
                      Get.toNamed("/game", arguments: item);
                    }
                  : null, // ❌ disable click

              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isRunning ? Colors.green : Colors.purple,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  _getStatusText(status),
                  style: TextStyle(
                    color: isRunning ? Colors.green : Colors.purple,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 STATUS TEXT
  String _getStatusText(String status) {
    switch (status.toUpperCase()) {
      case "RUNNING":
        return "PLAY GAME";
      case "UPCOMING":
        return "UPCOMING";
      default:
        return "BAZAAR CLOSED";
    }
  }
}
