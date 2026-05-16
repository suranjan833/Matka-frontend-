/// place_bet_controller.dart
library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceBetController extends GetxController {
  late Map<String, dynamic> bazaar;
  late Map<String, dynamic> gameType;

  final numberController = TextEditingController();
  final amountController = TextEditingController();

  RxString timeLeft = "00:00:00".obs;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    bazaar = args['bazaar'] ?? {};
    gameType = args['game_type'] ?? {};

    print(args);

    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      calculateRemainingTime();
    });
  }

  void calculateRemainingTime() {
    try {
      final endTime = bazaar['end_time'];

      final now = DateTime.now();

      final split = endTime.split(":");

      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(split[0]),
        int.parse(split[1]),
        0,
      );

      final difference = endDateTime.difference(now);

      if (difference.isNegative) {
        timeLeft.value = "Closed";
        timer?.cancel();
        return;
      }

      final hours = difference.inHours.toString().padLeft(2, '0');

      final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');

      final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

      timeLeft.value = "$hours:$minutes:$seconds";
    } catch (e) {
      timeLeft.value = "00:00:00";
    }
  }

  void placeBet() {
    final number = numberController.text.trim();
    final amount = amountController.text.trim();

    if (number.isEmpty) {
      Get.snackbar("Error", "Enter Number");
      return;
    }

    if (amount.isEmpty) {
      Get.snackbar("Error", "Enter Amount");
      return;
    }

    if (number.length != gameType['digits']) {
      Get.snackbar("Error", "Number must be ${gameType['digits']} digit");
      return;
    }

    /// 🔥 API CALL HERE

    Get.snackbar("Success", "Bet Placed Successfully");
  }

  @override
  void onClose() {
    timer?.cancel();

    numberController.dispose();
    amountController.dispose();

    super.onClose();
  }
}
