/// place_bet_view.dart

library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/place_bet_controller.dart';

class PlaceBetView extends GetView<PlaceBetController> {
  const PlaceBetView({super.key});

  static const primaryColor = Color(0xFF7B61FF);
  static const primaryLight = Color(0xFF9C8CFF);
  static const primaryDark = Color(0xFF5A3FD4);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlaceBetController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            /// ─── GRADIENT HEADER ────────────────────────────────────────────
            _buildHeader(controller),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    /// ─── FORM OR REVIEW ───────────────────────────────────────
                    Obx(() {
                      if (controller.isReviewing.value) {
                        return _buildReviewCard(controller);
                      }
                      return _buildFormCard(controller);
                    }),

                    SizedBox(height: 30.h),

                    /// ─── BUTTONS ──────────────────────────────────────────────
                    Obx(() {
                      if (controller.isReviewing.value) {
                        return _buildConfirmCancelButtons(controller);
                      }
                      return _buildPlaceBetButton(controller);
                    }),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ─── HEADER ──────────────────────────────────────────────────────────────
  Widget _buildHeader(PlaceBetController controller) {
    final bazaarName = controller.bazaar['name']?.toString() ?? '';
    final gameName = controller.gameType['name']?.toString() ?? '';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      bazaarName,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .7),
                        fontSize: 13.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
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

          SizedBox(height: 16.h),

          /// Timer
          Obx(
            () => Row(
              children: [
                Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time Left",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .7),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      controller.timeLeft.value,
                      style: TextStyle(
                        color: controller.timeLeft.value == "Closed"
                            ? Colors.red.shade300
                            : Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        fontFeatures: const [FontFeature.tabularFigures()],
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

  /// ─── FORM CARD ──────────────────────────────────────────────────────────
  Widget _buildFormCard(PlaceBetController controller) {
    final code = controller.gameType['code']?.toString() ?? '';
    final (String hint, TextInputType inputType, int? maxLen) = _numberInputSpec(code);
    final description = _gameHint(code);

    return Transform.translate(
      offset: Offset(0, -16.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Number Field
            Row(
              children: [
                Text(
                  "Enter Number",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B61FF).withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    controller.gameType['description'] ?? code,
                    style: TextStyle(
                      color: const Color(0xFF7B61FF),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            /// Description hint
            if (description.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            TextField(
              controller: controller.numberController,
              keyboardType: inputType,
              maxLength: maxLen,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
                letterSpacing: 2,
              ),
              decoration: _inputDecoration(
                hintText: hint,
                prefixIcon: Icons.tag_rounded,
              ),
            ),

            SizedBox(height: 16.h),

            /// Amount Field
            Text(
              "Enter Amount",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              decoration: _inputDecoration(
                hintText: "Enter Amount",
                prefixIcon: Icons.currency_rupee_rounded,
              ),
            ),

            SizedBox(height: 16.h),

            /// Quick Amount
            Text(
              "Quick Amount",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [100, 200, 500, 1000, 2000, 5000].map((amount) {
                final isSelected = controller.amountController.text == amount.toString();
                return GestureDetector(
                  onTap: () {
                    controller.amountController.text = amount.toString();
                    controller.amountController.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.amountController.text.length),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withValues(alpha: .1)
                          : const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? primaryColor.withValues(alpha: .3)
                            : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      "₹$amount",
                      style: TextStyle(
                        color: isSelected ? primaryColor : Colors.grey.shade600,
                        fontSize: 14.sp,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// ─── REVIEW CARD ─────────────────────────────────────────────────────────
  Widget _buildReviewCard(PlaceBetController controller) {
    final number = controller.numberController.text.trim();
    final amount = controller.amountController.text.trim();

    return Transform.translate(
      offset: Offset(0, -16.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            /// Icon
            Container(
              height: 56.h,
              width: 56.h,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                color: primaryColor,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 16.h),

            /// Title
            Text(
              "Review Your Bet",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),

            Text(
              "Please verify the details below",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13.sp,
              ),
            ),

            SizedBox(height: 20.h),

            /// Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                children: [
                  _reviewRow(
                    label: "Game Type",
                    value: controller.gameType['name']?.toString() ?? '',
                    icon: Icons.sports_esports_outlined,
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: Colors.grey.shade200, height: 1),
                  SizedBox(height: 12.h),
                  _reviewRow(
                    label: "Your Number",
                    value: number,
                    icon: Icons.tag_rounded,
                    valueColor: primaryColor,
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: Colors.grey.shade200, height: 1),
                  SizedBox(height: 12.h),
                  _reviewRow(
                    label: "Bet Amount",
                    value: "₹$amount",
                    icon: Icons.currency_rupee_rounded,
                    valueColor: Colors.green.shade600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reviewRow({
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Container(
          height: 32.h,
          width: 32.h,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: primaryColor, size: 16.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14.sp,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  /// ─── INPUT SPEC BY GAME CODE ───────────────────────────────────────────
  (String hint, TextInputType inputType, int? maxLen) _numberInputSpec(String code) {
    switch (code) {
      case "SINGLE":
        return ("Single digit 0-9", TextInputType.number, 1);
      case "SINGLE_BULK":
        return ("e.g. 1,3,7 (comma separated)", TextInputType.text, null);
      case "JODI":
        return ("Two digits 00-99", TextInputType.number, 2);
      case "JODI_BULK":
        return ("e.g. 27,53,84 (comma separated)", TextInputType.text, null);
      case "SP":
        return ("3 different digits (e.g. 123)", TextInputType.number, 3);
      case "SP_BULK":
        return ("e.g. 123,456,789", TextInputType.text, null);
      case "DP":
        return ("3 digits with one repeat (e.g. 112)", TextInputType.number, 3);
      case "DP_BULK":
        return ("e.g. 112,336,443", TextInputType.text, null);
      case "TP":
        return ("3 same digits (e.g. 111)", TextInputType.number, 3);
      case "SPM":
        return ("Min 4 digits (Single Pana)", TextInputType.number, null);
      case "DPM":
        return ("Min 4 digits (Double Pana)", TextInputType.number, null);
      case "GROUP_JODI":
        return ("Two digits (e.g. 27)", TextInputType.number, 2);
      case "RB":
        return ("Two digits", TextInputType.number, 2);
      case "HS":
        return ("e.g. 123-4 (Pana-Ank)", TextInputType.text, null);
      case "FS":
        return ("e.g. 123-456 (Pana-Pana)", TextInputType.text, null);
      default:
        return ("Enter number", TextInputType.number, null);
    }
  }

  String _gameHint(String code) {
    switch (code) {
      case "SINGLE":
        return "Bet on a single digit 0-9. Win if your number matches the result.";
      case "SINGLE_BULK":
        return "Enter multiple single digits separated by commas (e.g. 1,3,7)";
      case "JODI":
        return "Bet on a two-digit pair 00-99. Win if your pair matches.";
      case "JODI_BULK":
        return "Enter multiple Jodis separated by commas (e.g. 27,53,84)";
      case "SP":
        return "3 different digits. Sum determines your Ank. (e.g. 123 → sum=6 → Ank=6)";
      case "SP_BULK":
        return "Enter multiple Single Pana numbers separated by commas";
      case "DP":
        return "3 digits with one repeating. Win if pattern matches. (e.g. 112, 336)";
      case "DP_BULK":
        return "Enter multiple Double Pana numbers separated by commas";
      case "TP":
        return "All 3 digits same. (e.g. 111, 222, 333)";
      case "SPM":
        return "Motor Single Pana — minimum 4 digits, all different.";
      case "DPM":
        return "Motor Double Pana — minimum 4 digits, one repeats.";
      case "GROUP_JODI":
        return "Covers all combinations. Bet 27 → wins 27,72,22,77";
      case "RB":
        return "Special Jodi bracket betting.";
      case "HS":
        return "Format: Pana-Ank. Predict 3-digit Pana + 1-digit Ank from same side.";
      case "FS":
        return "Format: Open Pana-Close Pana. Both 3-digit Pana must match.";
      default:
        return "";
    }
  }

  /// ─── INPUT DECORATION ───────────────────────────────────────────────────
  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      counterText: "",
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey.shade400,
        fontSize: 15.sp,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.grey.shade400,
        size: 22.sp,
      ),
      filled: true,
      fillColor: const Color(0xFFF5F7FA),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: Colors.grey.shade100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: primaryColor.withValues(alpha: .5),
          width: 1.5,
        ),
      ),
    );
  }

  /// ─── PLACE BET BUTTON ───────────────────────────────────────────────────
  Widget _buildPlaceBetButton(PlaceBetController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        height: 54.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: controller.placeBet,
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primaryColor, primaryLight],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: .4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
                  SizedBox(width: 8.w),
                  Text(
                    "PLACE BET",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ─── CONFIRM / CANCEL BUTTONS ──────────────────────────────────────────
  Widget _buildConfirmCancelButtons(PlaceBetController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          /// Confirm Bet
          SizedBox(
            width: double.infinity,
            height: 54.h,
            child: Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.zero,
                ),
                onPressed: controller.isPlacing.value ? null : controller.confirmBet,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00C853), Color(0xFF69F0AE)],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00C853).withValues(alpha: .4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: controller.isPlacing.value
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 22),
                              SizedBox(width: 8.w),
                              Text(
                                "CONFIRM BET",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          /// Cancel
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: TextButton(
              onPressed: controller.cancelReview,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
