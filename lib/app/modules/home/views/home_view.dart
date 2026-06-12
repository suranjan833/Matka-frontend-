// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const primaryColor = Color(0xFF7B61FF);
  static const primaryDark = Color(0xFF5A3FD4);
  static const primaryLight = Color(0xFF9C8CFF);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                child: Column(
                  children: [
                    const _BannerCarousel(),
                    SizedBox(height: 20.h),
                    _buildActionRow(),
                    SizedBox(height: 24.h),
                    _buildSectionHeader("Game Categories"),
                    SizedBox(height: 14.h),
                    _buildCategoryGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ─── APPBAR ───────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            /// Avatar + Welcome
            Container(
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, primaryLight],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Obx(() {
                final name = controller.profileData['name'] ?? 'U';
                final letter = name.toString().isNotEmpty
                    ? name.toString()[0].toUpperCase()
                    : 'U';
                return Center(
                  child: Text(
                    letter,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Obx(() {
                if (controller.isProfileLoading.value) {
                  return _shimmerText(width: 120.w);
                }
                final name = controller.profileData['name'] ?? 'User';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome back,",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      name.toString(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              }),
            ),

            /// Wallet Chip
            Obx(() {
              if (controller.isWalletLoading.value) {
                return _shimmerContainer(width: 80.w, height: 36.h);
              }
              final balance = controller.wallet['balance'] ?? '0';
              return Container(
                constraints: BoxConstraints(maxWidth: 110.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryColor, primaryLight],
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: .3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        "₹$balance",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.white.withValues(alpha: .85),
                      size: 14.sp,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// ─── ACTION ROW (ADD MONEY / WITHDRAW) ───────────────────────────────────
  Widget _buildActionRow() {
    return Row(
      children: [
        Expanded(child: _actionCard(
          title: "Add Money",
          icon: Icons.add_card_outlined,
          gradientColors: const [primaryColor, primaryLight],
          onTap: () => Get.toNamed('/add-money'),
        )),
        SizedBox(width: 12.w),
        Expanded(child: _actionCard(
          title: "Withdraw",
          icon: Icons.arrow_circle_up_outlined,
          gradientColors: const [Color(0xFF00C853), Color(0xFF69F0AE)],
          onTap: () => Get.toNamed('/withdraw-page'),
        )),
      ],
    );
  }

  Widget _actionCard({
    required String title,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withValues(alpha: .3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 32.h,
                width: 32.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: Colors.white, size: 18.sp),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: .7),
                size: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ─── SECTION HEADER ───────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          height: 24.h,
          width: 4.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primaryColor, primaryLight],
            ),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  /// ─── CATEGORY GRID ────────────────────────────────────────────────────────
  Widget _buildCategoryGrid() {
    return Obx(() {
      if (controller.isCategoryLoading.value) {
        return _buildCategoryShimmer();
      }

      if (controller.categories.isEmpty) {
        return Container(
          height: 200.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.category_outlined,
                  size: 48.sp, color: Colors.grey.shade300),
              SizedBox(height: 12.h),
              Text(
                "No Categories Available",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        );
      }

      return GridView.builder(
        itemCount: controller.categories.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          final item = controller.categories[index];
          return _gridCard(item, index);
        },
      );
    });
  }

  Widget _gridCard(Map<String, dynamic> item, int index) {
    final title = item['name']?.toString() ?? '';
    final colors = _cardGradient(index);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            "/bazaar",
            arguments: {"category_id": item['id'] ?? 0, "category_name": title},
          );
        },
        borderRadius: BorderRadius.circular(16.r),
        splashColor: Colors.white.withValues(alpha: .1),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: colors[0].withValues(alpha: .25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  height: 42.h,
                  width: 42.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .18),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    _categoryIcon(index),
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withValues(alpha: .5),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ─── CARD GRADIENTS ──────────────────────────────────────────────────────
  List<Color> _cardGradient(int index) {
    final gradients = [
      [primaryColor, primaryLight],
      [const Color(0xFFFF6B6B), const Color(0xFFFFA07A)],
      [const Color(0xFF00B4D8), const Color(0xFF48CAE4)],
      [const Color(0xFF7B2CBF), const Color(0xFFC77DFF)],
      [const Color(0xFF06D6A0), const Color(0xFF64DFB6)],
      [const Color(0xFFFF8C00), const Color(0xFFFFB347)],
    ];
    return gradients[index % gradients.length];
  }

  /// ─── CATEGORY ICONS ──────────────────────────────────────────────────────
  IconData _categoryIcon(int index) {
    final icons = [
      Icons.casino_rounded,
      Icons.trending_up_rounded,
      Icons.sports_esports_rounded,
      Icons.auto_awesome_rounded,
      Icons.star_rounded,
      Icons.bolt_rounded,
    ];
    return icons[index % icons.length];
  }

  /// ─── SHIMMER LOADING ──────────────────────────────────────────────────────
  Widget _shimmerContainer({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }

  Widget _shimmerText({required double width}) {
    return Container(
      width: width,
      height: 14.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  height: 42.h,
                  width: 42.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ─── BANNER CAROUSEL ─────────────────────────────────────────────────────────
class _BannerItem {
  final IconData icon;
  final String tag;
  final String title;
  final MaterialColor tagColor;
  final String subtitle;
  final List<Color> gradientColors;

  const _BannerItem({
    required this.icon,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    this.tagColor = Colors.amber,
  });
}

class _BannerCarousel extends StatefulWidget {
  const _BannerCarousel();

  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  static const _banners = [
    _BannerItem(
      icon: Icons.emoji_events_rounded,
      tag: "PLAY & WIN BIG!",
      title: "Matka Games\nat Your Fingertips",
      subtitle: "Choose your game & start playing",
      gradientColors: [Color(0xFF7B61FF), Color(0xFF5A3FD4)],
      tagColor: Colors.amber,
    ),
    _BannerItem(
      icon: Icons.card_giftcard_rounded,
      tag: "WELCOME BONUS",
      title: "Get ₹100\nWelcome Bonus",
      subtitle: "Sign up & start with extra cash",
      gradientColors: [Color(0xFFFF6B6B), Color(0xFFE53935)],
      tagColor: Colors.orange,
    ),
    _BannerItem(
      icon: Icons.star_rounded,
      tag: "DAILY REWARDS",
      title: "Earn Daily\nCash Rewards",
      subtitle: "Play daily to earn more",
      gradientColors: [Color(0xFF00B4D8), Color(0xFF0077B6)],
      tagColor: Colors.cyan,
    ),
  ];

  final _pageController = PageController(viewportFraction: 1.0);
  final _currentPage = 0.obs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;
      final nextPage = (_currentPage.value + 1) % _banners.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _onPageChanged(int page) {
    _currentPage.value = page;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Page View
        SizedBox(
          height: 150.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _banners.length,
            itemBuilder: (context, index) => _BannerSlide(
              item: _banners[index],
            ),
          ),
        ),

        SizedBox(height: 12.h),

        /// Dot Indicators
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_banners.length, (i) {
              final isActive = _currentPage.value == i;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                height: 6.h,
                width: isActive ? 20.w : 6.w,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF7B61FF)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

/// ─── BANNER SLIDE ─────────────────────────────────────────────────────────────
class _BannerSlide extends StatelessWidget {
  final _BannerItem item;

  const _BannerSlide({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: item.gradientColors,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: item.gradientColors[0].withValues(alpha: .35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          /// Decorative circles
          Positioned(
            top: -20.h,
            right: -10.w,
            child: Container(
              height: 100.h,
              width: 100.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30.h,
            left: -20.w,
            child: Container(
              height: 130.h,
              width: 130.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 20.h,
            right: 30.w,
            child: Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// Content
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      item.icon,
                      color: item.tagColor.shade200,
                      size: 22.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      item.tag,
                      style: TextStyle(
                        color: item.tagColor.shade200,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .8),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      height: 28.h,
                      width: 28.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
