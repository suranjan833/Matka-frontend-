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
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

        title: Text(
          controller.bazaar['name'] ?? "Game Types",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.w),

        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.gameTypes.length,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 1.08,
          ),

          itemBuilder: (context, index) {
            final item = controller.gameTypes[index];

            return InkWell(
              borderRadius: BorderRadius.circular(24.r),

              onTap: () {
                Get.toNamed(
                  "/place-bet",
                  arguments: {"bazaar": controller.bazaar, "game_type": item},
                );
              },

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),

                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade700,
                    ],
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: .18),
                      blurRadius: 14,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Padding(
                  padding: EdgeInsets.all(16.w),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 52.h,
                        width: 52.h,

                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(14.r),
                        ),

                        child: Icon(
                          _getIcon(item['code']),
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        item['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(50.r),
                        ),

                        child: Text(
                          "${item['digits']} Digit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getIcon(String code) {
    switch (code) {
      case "SINGLE":
        return Icons.looks_one_rounded;

      case "JODI":
        return Icons.filter_2_rounded;

      case "SP":
        return Icons.pin_outlined;

      case "DP":
        return Icons.grid_view_rounded;

      case "TP":
        return Icons.auto_awesome_rounded;

      case "HS":
        return Icons.bolt_rounded;

      case "FS":
        return Icons.workspace_premium_rounded;

      case "RB":
        return Icons.crop_square_rounded;

      default:
        return Icons.casino_rounded;
    }
  }
}
