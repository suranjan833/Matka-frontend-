/// gametypes_view.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/gametypes_controller.dart';

class GameTypesView extends GetView<GameTypesController> {
  const GameTypesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GameTypesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.bazaar['name'] ?? "Game Types"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(15.w),

        child: GridView.builder(
          itemCount: controller.gameTypes.length,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 15.h,
            childAspectRatio: 1.2,
          ),

          itemBuilder: (context, index) {
            final item = controller.gameTypes[index];

            return GestureDetector(
              onTap: () {
                /// 🔥 Next Screen
                /// number + amount input screen

                Get.toNamed(
                  "/place-bet",
                  arguments: {"bazaar": controller.bazaar, "game_type": item},
                );
              },

              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.deepPurple],
                  ),

                  borderRadius: BorderRadius.circular(18.r),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.casino, color: Colors.white, size: 40.sp),

                    SizedBox(height: 12.h),

                    Text(
                      item['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      "${item['digits']} Digit",
                      style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
