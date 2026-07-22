import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../BetType/bet_type.dart';
import '../../BetType/pana_chart_data.dart';
import '../../../services/bet_slip_service.dart';
import '../controllers/bet_input_page_controller.dart';

class BetInputPageView extends GetView<BetInputPageController> {
  const BetInputPageView({super.key});

  static const primaryColor = Color(0xff1673E6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      _buildInputSection(),
                      SizedBox(height: 16.h),
                      Obx(() {
                        final betSlip = Get.find<BetSlipService>();
                        if (betSlip.items.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          children: [
                            _buildBetTable(betSlip),
                            SizedBox(height: 16.h),
                            _buildTotalRow(betSlip),
                            SizedBox(height: 16.h),
                            _buildPlaceBetButton(),
                            SizedBox(height: 16.h),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: const Color(0xffF6F8FB),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black87,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.betType.displayName,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  controller.market['name'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bet type label
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: controller.betType.color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  controller.betType.icon,
                  color: controller.betType.color,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter ${controller.betType.displayName}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    controller.betType.subtitle,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Number input - adapted to bet type
          controller.betType.isSingleDigitSelect
              ? _buildDigitGrid()
              : controller.betType.isToggleSelection
                  ? _buildToggleButtons()
                  : controller.betType.isPanaSelect
                      ? _buildPanaPicker()
                      : _buildTextFieldInput(),

          SizedBox(height: 16.h),

          // Amount input
          _buildAmountInput(),

          SizedBox(height: 6.h),

          // Error message
          Obx(() {
            if (controller.errorMessage.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xffFEE2E2),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xffFCA5A5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: const Color(0xffEF4444),
                      size: 16.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        controller.errorMessage.value,
                        style: TextStyle(
                          color: const Color(0xffDC2626),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 20.h),

          // Add to Bet button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
                onPressed: () => controller.validateAndAdd(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outline, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Add to Bet',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    final isOddEven = controller.betType == BetTypeCategory.oddEven;
    final options = isOddEven ? ['Odd', 'Even'] : ['Big', 'Small'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select ${isOddEven ? "Odd or Even" : "Big or Small"}:',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: options.map((option) {
            final lowerOpt = option.toLowerCase();
            final isSelected =
                controller.selectedSingleDigit.value == lowerOpt;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: GestureDetector(
                  onTap: () => controller.onDigitSelected(lowerOpt),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 56.h,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? primaryColor : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14.r),
                      border: isSelected
                          ? Border.all(color: primaryColor, width: 2.w)
                          : Border.all(color: Colors.transparent),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: .3),
                                blurRadius: 8.r,
                                offset: Offset(0, 3.h),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color:
                              isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPanaPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select ${controller.betType.isBulkType ? "numbers" : "a number"} from chart:',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.h),
        _buildFamilyChips(),
        SizedBox(height: 8.h),
        _buildPanaGrid(),
        _buildSelectedPanaIndicator(),
      ],
    );
  }

  Widget _buildFamilyChips() {
    return Obx(() {
      final selectedFamily = controller.selectedFamilyDigit.value;
      return SizedBox(
        height: 34.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          separatorBuilder: (_, _) => SizedBox(width: 8.w),
          itemBuilder: (context, index) {
            final isSelected = selectedFamily == index;
            final color = PanaChartData.familyColor(index);
            return GestureDetector(
              onTap: () => controller.onFamilyDigitSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 34.w,
                height: 34.h,
                decoration: BoxDecoration(
                  color: isSelected ? color : color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? color : Colors.transparent,
                    width: 1.5.w,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: .3),
                            blurRadius: 6.r,
                            offset: Offset(0, 2.h),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.white : color,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildPanaGrid() {
    return Obx(() {
      final selectedFamily = controller.selectedFamilyDigit.value;
      final numbers = PanaChartData.numbersForBetType(
        controller.betType,
        selectedFamily,
      );

      if (numbers.isEmpty) return const SizedBox.shrink();

      final isTriple = controller.betType == BetTypeCategory.triplePana;
      final crossAxisCount = isTriple ? 5 : 4;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Family $selectedFamily — ${_typeLabel()}',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: PanaChartData.familyColor(selectedFamily),
            ),
          ),
          SizedBox(height: 8.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 8.w,
              childAspectRatio: isTriple ? 1.5 : 2.0,
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              final pana = numbers[index];
              final isSelected = controller.betType.isBulkType
                  ? controller.selectedPanaNumbers.contains(pana)
                  : controller.selectedPanaNumber.value == pana;
              return GestureDetector(
                onTap: () => controller.onPanaNumberSelected(pana),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? PanaChartData.familyColor(selectedFamily)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? PanaChartData.familyColor(selectedFamily)
                          : Colors.grey.shade200,
                      width: isSelected ? 1.5.w : 1.w,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: PanaChartData.familyColor(selectedFamily)
                                  .withValues(alpha: .25),
                              blurRadius: 4.r,
                              offset: Offset(0, 2.h),
                            ),
                          ]
                        : [],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Center(
                    child: Text(
                      pana,
                      style: TextStyle(
                        fontSize: isTriple ? 14.sp : 12.sp,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : Colors.black87,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildSelectedPanaIndicator() {
    return Obx(() {
      if (controller.betType.isBulkType) {
        // Bulk type: show chips for all selected numbers
        if (controller.selectedPanaNumbers.isEmpty) {
          return const SizedBox.shrink();
        }
        return _buildSelectedPanaChips();
      } else {
        // Single selection: show one selected number chip
        if (controller.selectedPanaNumber.value.isEmpty) {
          return const SizedBox.shrink();
        }
        return _buildSingleSelectedChip();
      }
    });
  }

  Widget _buildSingleSelectedChip() {
    final pana = controller.selectedPanaNumber.value;
    final color = PanaChartData.familyColor(controller.selectedFamilyDigit.value);
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected:',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: color.withValues(alpha: .4),
                width: 1.5.w,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_rounded, size: 16.sp, color: color),
                SizedBox(width: 6.w),
                Text(
                  pana,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: color,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedPanaChips() {
    return Obx(() {
      if (controller.selectedPanaNumbers.isEmpty) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected (${controller.selectedPanaNumbers.length}):',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: controller.selectedPanaNumbers.map((pana) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: PanaChartData.familyColor(
                            controller.selectedFamilyDigit.value)
                        .withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: PanaChartData.familyColor(
                              controller.selectedFamilyDigit.value)
                          .withValues(alpha: .3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        pana,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: PanaChartData.familyColor(
                              controller.selectedFamilyDigit.value),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: () =>
                            controller.onPanaNumberSelected(pana),
                        child: Icon(
                          Icons.close_rounded,
                          size: 14.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }

  String _typeLabel() {
    switch (controller.betType) {
      case BetTypeCategory.singlePana:
      case BetTypeCategory.singlePanaBulk:
        return 'Single Pana';
      case BetTypeCategory.doublePana:
      case BetTypeCategory.doublePanaBulk:
        return 'Double Pana';
      case BetTypeCategory.triplePana:
        return 'Triple Pana';
      default:
        return '';
    }
  }

  Widget _buildDigitGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your digit:',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: 1,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            final digit = '$index';
            final isSelected = controller.selectedSingleDigit.value == digit;
            return GestureDetector(
              onTap: () => controller.onDigitSelected(digit),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                  border: isSelected
                      ? Border.all(color: primaryColor, width: 2.w)
                      : Border.all(color: Colors.transparent),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: .3),
                            blurRadius: 8.r,
                            offset: Offset(0, 3.h),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    digit,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTextFieldInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter number:',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller.numberController,
          onChanged: controller.onNumberChanged,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: controller.betType.inputHint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: primaryColor,
                width: 1.5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bet Amount (₹)',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller.amountController,
          onChanged: controller.onAmountChanged,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            prefixText: '₹ ',
            prefixStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: primaryColor,
            ),
            hintText: 'e.g. 100',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: primaryColor,
                width: 1.5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBetTable(BetSlipService betSlip) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: Row(
              children: [
                Icon(Icons.table_chart_outlined, color: primaryColor, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  'Your Bets',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: controller.clearAllBets,
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade200, height: 1),
          // Column headers
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Bet Number',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: Text(
                    'Amount',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                SizedBox(width: 36.w),
              ],
            ),
          ),
          // Table rows
          Obx(
            () => Column(
              children: List.generate(betSlip.items.length, (index) {
                final item = betSlip.items[index];
                return Column(
                  children: [
                    Divider(color: Colors.grey.shade100, height: 1),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: BoxDecoration(
                                    color: item.betType.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  item.numbers,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              '₹${item.amount.toStringAsFixed(0)}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () => controller.removeBet(index),
                            child: Container(
                              width: 28.w,
                              height: 28.w,
                              decoration: BoxDecoration(
                                color: const Color(0xffFEE2E2),
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: const Color(0xffEF4444),
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(BetSlipService betSlip) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: primaryColor.withValues(alpha: .15)),
      ),
      child: Row(
        children: [
          Icon(Icons.receipt_long_rounded, color: primaryColor, size: 18.sp),
          SizedBox(width: 8.w),
          Text(
            'Total (${betSlip.itemCount} bet) :',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const Spacer(),
          Obx(
            () => Text(
              '₹${betSlip.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceBetButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: controller.placeBets,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff22C55E),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
          shadowColor: const Color(0xff22C55E).withValues(alpha: .3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'Place Bet',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
