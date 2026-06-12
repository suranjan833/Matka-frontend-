import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/bazaar_controller.dart';

class BazaarView extends GetView<BazaarController> {
  const BazaarView({super.key});

  static const primaryColor = Color(0xFF7B61FF);
  static const primaryLight = Color(0xFF9C8CFF);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BazaarController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          controller.categoryName,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getBazaar(),
        color: const Color(0xFF7B61FF),
        displacement: 40,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const _ShimmerLoading();
          }

          if (controller.bazaarList.isEmpty) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: 400.h,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.store_mall_directory_outlined,
                        size: 64.sp,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "No Bazaar Available",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Check back later for new listings",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.bazaarList.length,
            itemBuilder: (context, index) {
              final item = controller.bazaarList[index];
              return _BazaarCard(item: item, index: index);
            },
          );
        }),
      ),
    );
  }
}

/// ─── BAZAAR CARD ─────────────────────────────────────────────────────────────
class _BazaarCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final int index;

  const _BazaarCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final name = item['name']?.toString() ?? '';
    final start = item['start_time']?.toString() ?? '';
    final end = item['end_time']?.toString() ?? '';
    final status = item['game_status']?.toString().toUpperCase() ?? 'CLOSED';

    final isRunning = status == "RUNNING";
    final isUpcoming = status == "UPCOMING";

    final cardColors = _cardGradient(index);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// ─── GRADIENT HEADER ─────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: cardColors,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name + Status Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    _StatusBadge(status: status),
                  ],
                ),

                SizedBox(height: 14.h),

                /// Divider
                Container(height: 1, color: Colors.white.withValues(alpha: .2)),

                SizedBox(height: 12.h),

                /// Time Row
                Row(
                  children: [
                    _TimeInfo(
                      icon: Icons.schedule_rounded,
                      label: "Start",
                      time: _formatTime(start),
                    ),
                    SizedBox(width: 20.w),
                    _TimeInfo(
                      icon: Icons.timer_outlined,
                      label: "End",
                      time: _formatTime(end),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// ─── BOTTOM SECTION ────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                /// Status indicator
                Flexible(
                  child: _StatusIndicator(
                    isRunning: isRunning,
                    isUpcoming: isUpcoming,
                  ),
                ),
                SizedBox(width: 12.w),

                /// Play Button
                _PlayButton(
                  isRunning: isRunning,
                  isUpcoming: isUpcoming,
                  gradientColors: cardColors,
                  onTap: isRunning
                      ? () {
                          Get.toNamed("/gametypes", arguments: item);
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ─── FORMAT TIME SAFELY ──────────────────────────────────────────────────
  String _formatTime(String time) {
    if (time.length >= 5) return time.substring(0, 5);
    return time;
  }

  /// ─── CARD GRADIENTS ──────────────────────────────────────────────────────
  List<Color> _cardGradient(int index) {
    const primaryColor = Color(0xFF7B61FF);
    const primaryLight = Color(0xFF9C8CFF);

    final gradients = [
      [primaryColor, primaryLight],
      [const Color(0xFFFF6B6B), const Color(0xFFFFA07A)],
      [const Color(0xFF00B4D8), const Color(0xFF48CAE4)],
      [const Color(0xFF7B2CBF), const Color(0xFFC77DFF)],
      [const Color(0xFF06D6A0), const Color(0xFF64DFB6)],
      [const Color(0xFFFF8C00), const Color(0xFFFFB347)],
      [const Color(0xFFE91E63), const Color(0xFFF48FB1)],
      [const Color(0xFF00BCD4), const Color(0xFF4DD0E1)],
    ];
    return gradients[index % gradients.length];
  }
}

/// ─── STATUS BADGE ─────────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (Color bgColor, Color textColor, String label) = switch (status) {
      "RUNNING" => (Colors.green.shade100, const Color(0xFF1B5E20), "●  LIVE"),
      "UPCOMING" => (
        Colors.amber.shade100,
        const Color(0xFFE65100),
        "●  UPCOMING",
      ),
      _ => (Colors.grey.shade200, Colors.grey.shade700, "●  CLOSED"),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: .9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// ─── TIME INFO ────────────────────────────────────────────────────────────────
class _TimeInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;

  const _TimeInfo({
    required this.icon,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 28.h,
          width: 28.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: Colors.white, size: 16.sp),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: .7),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              time,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// ─── STATUS INDICATOR ─────────────────────────────────────────────────────────
class _StatusIndicator extends StatelessWidget {
  final bool isRunning;
  final bool isUpcoming;

  const _StatusIndicator({required this.isRunning, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    final (Color dotColor, String message) = switch ((isRunning, isUpcoming)) {
      (true, _) => (Colors.green, "Game is active • Play now"),
      (_, true) => (Colors.amber, "Available soon"),
      _ => (Colors.grey, "Currently unavailable"),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 8.h,
          width: 8.h,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: dotColor.withValues(alpha: .4), blurRadius: 4),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// ─── PLAY BUTTON ──────────────────────────────────────────────────────────────
class _PlayButton extends StatelessWidget {
  final bool isRunning;
  final bool isUpcoming;
  final List<Color> gradientColors;
  final VoidCallback? onTap;

  const _PlayButton({
    required this.isRunning,
    required this.isUpcoming,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRunning && !isUpcoming) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          "CLOSED",
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      );
    }

    if (isUpcoming) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: Text(
          "UPCOMING",
          style: TextStyle(
            color: Colors.amber.shade800,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors),
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withValues(alpha: .35),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20.sp),
              SizedBox(width: 6.w),
              Text(
                "PLAY GAME",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ─── SHIMMER LOADING ──────────────────────────────────────────────────────────
class _ShimmerLoading extends StatefulWidget {
  const _ShimmerLoading();

  @override
  State<_ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<_ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      child: Column(children: List.generate(4, (_) => _buildShimmerCard())),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          /// ─── SHIMMER HEADER ────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
              ),
              color: Colors.grey.shade200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name + Badge row
                Row(
                  children: [
                    _shimmerBox(width: 120.w, height: 18.h),
                    const Spacer(),
                    _shimmerBox(width: 60.w, height: 22.h, radius: 20.r),
                  ],
                ),
                SizedBox(height: 16.h),
                _shimmerBox(width: double.infinity, height: 1),
                SizedBox(height: 14.h),

                /// Time info row
                Row(
                  children: [
                    _shimmerBox(width: 28.h, height: 28.h, radius: 8.r),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerBox(width: 30.w, height: 10.h),
                        SizedBox(height: 4.h),
                        _shimmerBox(width: 40.w, height: 14.h),
                      ],
                    ),
                    SizedBox(width: 20.w),
                    _shimmerBox(width: 28.h, height: 28.h, radius: 8.r),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerBox(width: 30.w, height: 10.h),
                        SizedBox(height: 4.h),
                        _shimmerBox(width: 40.w, height: 14.h),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// ─── SHIMMER BOTTOM ────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                _shimmerBox(width: 80.w, height: 12.h),
                const Spacer(),
                _shimmerBox(width: 100.w, height: 36.h, radius: 30.r),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    double? width,
    required double height,
    double radius = 6,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.r),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: [
                Colors.grey.shade200,
                Colors.grey.shade100,
                Colors.grey.shade200,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}
