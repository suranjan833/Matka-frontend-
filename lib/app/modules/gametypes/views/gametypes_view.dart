library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/gametypes_controller.dart';

class GameTypesView extends GetView<GameTypesController> {
  const GameTypesView({super.key});

  static const primaryColor = Color(0xFF7B61FF);
  static const primaryDark = Color(0xFF5A3FD4);
  static const primaryLight = Color(0xFF9C8CFF);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GameTypesController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: Column(
        children: [
          /// ─── GRADIENT HEADER ────────────────────────────────────────────
          _buildHeader(controller),

          /// ─── GAME LIST ──────────────────────────────────────────────────
          Expanded(
            child: _buildGameList(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(GameTypesController controller) {
    final bazaar = controller.bazaar;
    final name = bazaar['name'] ?? "Game Types";
    final startTime = bazaar['start_time']?.toString() ?? '';
    final endTime = bazaar['end_time']?.toString() ?? '';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 48.h, 20.w, 24.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryDark],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: .35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Back + Title
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 36.h,
                    width: 36.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// Divider
            Container(
              height: 1,
              color: Colors.white.withValues(alpha: .15),
            ),

            SizedBox(height: 14.h),

            /// Stats row
            Row(
              children: [
                _headerStat(
                  icon: Icons.sports_esports_outlined,
                  label: "${controller.gameTypes.length} Games",
                ),
                SizedBox(width: 20.w),
                if (startTime.length >= 5)
                  _headerStat(
                    icon: Icons.schedule_outlined,
                    label: _formatTime(startTime),
                  ),
                if (endTime.length >= 5) ...[
                  SizedBox(width: 12.w),
                  Text(
                    "—",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .5),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  _headerStat(
                    icon: Icons.timer_outlined,
                    label: _formatTime(endTime),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerStat({
    required IconData icon,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: .7), size: 16.sp),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: .85),
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatTime(String time) {
    if (time.length >= 5) return time.substring(0, 5);
    return time;
  }

  /// ─── GAME LIST ──────────────────────────────────────────────────────────
  Widget _buildGameList(GameTypesController controller) {
    final grouped = _groupGames(controller.gameTypes);

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
      physics: const BouncingScrollPhysics(),
      itemCount: grouped.length,
      itemBuilder: (context, sectionIndex) {
        final section = grouped[sectionIndex];
        return _GameSection(
          section: section,
          bazaar: controller.bazaar,
        );
      },
    );
  }

  /// ─── GROUP GAMES BY CATEGORY ───────────────────────────────────────────
  List<_GameSectionData> _groupGames(List<Map<String, dynamic>> games) {
    final Map<String, List<Map<String, dynamic>>> groups = {};

    for (final game in games) {
      final code = game['code']?.toString() ?? '';
      String category;

      if (code.startsWith("SINGLE") || code == "SINGLE_BULK") {
        category = "Single Digit";
      } else if (code.startsWith("JODI") || code == "GROUP_JODI") {
        category = "Jodi";
    } else if (code == "SP" || code == "DP" || code == "TP" ||
               code == "SP_BULK" || code == "DP_BULK") {
        category = "Pana";
      } else if (code == "SPM" || code == "DPM") {
        category = "Motor";
      } else if (code == "HS" || code == "FS") {
        category = "Sangam";
      } else {
        category = "Other";
      }

      groups.putIfAbsent(category, () => []);
      groups[category]!.add(game);
    }

    return groups.entries.map((e) => _GameSectionData(
      category: e.key,
      games: e.value,
    )).toList();
  }
}

/// ─── GAME SECTION ─────────────────────────────────────────────────────────────
class _GameSectionData {
  final String category;
  final List<Map<String, dynamic>> games;

  const _GameSectionData({
    required this.category,
    required this.games,
  });
}

class _GameSection extends StatelessWidget {
  final _GameSectionData section;
  final Map<String, dynamic> bazaar;

  const _GameSection({
    required this.section,
    required this.bazaar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section header
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            children: [
              Container(
                height: 20.h,
                width: 4.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B61FF), Color(0xFF9C8CFF)],
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                section.category,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF7B61FF).withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "${section.games.length}",
                  style: TextStyle(
                    color: const Color(0xFF7B61FF),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Game cards
        ...section.games.map((game) => _GameCard(
          game: game,
          bazaar: bazaar,
        )),

        SizedBox(height: 20.h),
      ],
    );
  }
}

/// ─── GAME CARD ─────────────────────────────────────────────────────────────────
class _GameCard extends StatelessWidget {
  final Map<String, dynamic> game;
  final Map<String, dynamic> bazaar;

  const _GameCard({
    required this.game,
    required this.bazaar,
  });

  static const primaryColor = Color(0xFF7B61FF);

  @override
  Widget build(BuildContext context) {
    final code = game['code']?.toString() ?? '';
    final name = game['name']?.toString() ?? '';
    final description = game['description']?.toString() ?? '';
    final digits = game['digits']?.toString() ?? description;
    final accentColor = _accentColor(code);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () {
            Get.toNamed(
              "/place-bet",
              arguments: {"bazaar": bazaar, "game_type": game},
            );
          },
          child: IntrinsicHeight(
            child: Row(
              children: [
                /// Accent bar
                Container(
                  width: 5.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accentColor, accentColor.withValues(alpha: .6)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      bottomLeft: Radius.circular(14.r),
                    ),
                  ),
                ),

                /// Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(14.w),
                    child: Row(
                      children: [
                        /// Icon
                        Container(
                          height: 44.h,
                          width: 44.h,
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            _getIcon(code),
                            color: accentColor,
                            size: 22.sp,
                          ),
                        ),

                        SizedBox(width: 14.w),

                        /// Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              if (digits.isNotEmpty)
                                Text(
                                  digits,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12.sp,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        SizedBox(width: 8.w),

                        /// Arrow
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey.shade300,
                          size: 22.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ─── ACCENT COLOR BY CODE ──────────────────────────────────────────────
  Color _accentColor(String code) {
    switch (code) {
      case "SINGLE":
      case "SINGLE_BULK":
        return const Color(0xFF7B61FF);
      case "JODI":
      case "JODI_BULK":
        return const Color(0xFFFF6B6B);
      case "SP":
      case "SP_BULK":
        return const Color(0xFF00B4D8);
      case "DP":
      case "DP_BULK":
        return const Color(0xFF06D6A0);
      case "TP":
        return const Color(0xFFFF8C00);
      case "SPM":
        return const Color(0xFFE91E63);
      case "DPM":
        return const Color(0xFFFF5722);
      case "GROUP_JODI":
        return const Color(0xFF9C27B0);
      case "RB":
        return const Color(0xFFD32F2F);
      case "HS":
        return const Color(0xFF00BCD4);
      case "FS":
        return const Color(0xFFFFC107);
      default:
        return primaryColor;
    }
  }

  /// ─── ICON MAP ────────────────────────────────────────────────────────────
  IconData _getIcon(String code) {
    switch (code) {
      case "SINGLE":
      case "SINGLE_BULK":
        return Icons.looks_one_rounded;
      case "JODI":
      case "JODI_BULK":
        return Icons.filter_2_rounded;
      case "SP":
      case "SP_BULK":
        return Icons.pin_outlined;
      case "DP":
      case "DP_BULK":
        return Icons.grid_view_rounded;
      case "TP":
        return Icons.auto_awesome_rounded;
      case "HS":
        return Icons.bolt_rounded;
      case "FS":
        return Icons.workspace_premium_rounded;
      case "RB":
        return Icons.crop_square_rounded;
      case "SPM":
        return Icons.rocket_launch_rounded;
      case "DPM":
        return Icons.local_fire_department_rounded;
      case "GROUP_JODI":
        return Icons.groups_rounded;
      default:
        return Icons.casino_rounded;
    }
  }
}
