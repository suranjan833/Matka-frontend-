import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

import '../../../config/app_config.dart';
import '../../../data/my_dio.dart';

class AddMoneyController extends GetxController {
  final amountController = TextEditingController();
  final transactionIdController = TextEditingController();

  var selectedAmount = 0.obs;
  var selectedPayment = ''.obs;
  var selectedImage = Rx<File?>(null);

  var isLoading = false.obs;
  var isTimerActive = false.obs;
  var remainingSeconds = 0.obs;
  var isPickingImage = false.obs;

  Timer? _timer;

  void setAmount(int amount) {
    if (isTimerActive.value) return;
    selectedAmount.value = amount;
    amountController.text = amount.toString();
  }

  void selectPayment(String method) {
    if (isTimerActive.value) return;
    selectedPayment.value = method;
  }

  Future<void> pickImage() async {
    if (isPickingImage.value) return;

    try {
      isPickingImage.value = true;

      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        selectedImage.value = File(picked.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Image pick failed");
    } finally {
      isPickingImage.value = false;
    }
  }

  void openPaymentDialog() {
    if (amountController.text.isEmpty) {
      Get.snackbar("Error", "Enter amount");
      return;
    }

    if (selectedPayment.value.isEmpty) {
      Get.snackbar("Error", "Select payment method");
      return;
    }

    selectedImage.value = null;
    transactionIdController.clear();

    Get.defaultDialog(
      title: "Upload Payment Proof",
      content: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Amount
            Text(
              "Amount: ₹${amountController.text}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// Transaction ID
            TextField(
              controller: transactionIdController,
              decoration: const InputDecoration(
                hintText: "Enter Transaction ID",
              ),
            ),

            const SizedBox(height: 15),

            /// Image Upload
            GestureDetector(
              onTap: isPickingImage.value ? null : pickImage,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isPickingImage.value
                    ? const Center(child: CircularProgressIndicator())
                    : selectedImage.value == null
                    ? const Center(child: Text("Upload Screenshot"))
                    : Image.file(selectedImage.value!, fit: BoxFit.cover),
              ),
            ),
          ],
        );
      }),
      textConfirm: "Submit",
      textCancel: "Cancel",
      onConfirm: () {
        submitPayment();
        Get.back();
      },
    );
  }

  Future<void> submitPayment() async {
    if (transactionIdController.text.isEmpty) {
      Get.snackbar("Error", "Enter transaction ID");
      return;
    }

    if (selectedImage.value == null) {
      Get.snackbar("Error", "Upload screenshot");
      return;
    }

    try {
      isLoading.value = true;

      final fileName = selectedImage.value!.path.split('/').last;

      final response = await dioPost(
        endUrl: "add_money.php",
        isFile: true,
        data: {
          "user_id": getBox.read(USER_ID).toString(),
          "amount": amountController.text,
          "payment_method": selectedPayment.value,
          "transaction_id": transactionIdController.text,
          "image": await dio.MultipartFile.fromFile(
            selectedImage.value!.path,
            filename: fileName,
          ),
        },
      );

      if (response.statusCode == 200) {
        startTimer();

        getBox.write("timer_start", DateTime.now().millisecondsSinceEpoch);

        Get.snackbar("Success", "Submitted successfully");
      } else {
        Get.snackbar("Error", "Server Error");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// ================================
  /// TIMER
  /// ================================
  void startTimer() {
    if (isTimerActive.value) return;

    isTimerActive.value = true;
    remainingSeconds.value = 600;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        isTimerActive.value = false;
        getBox.remove("timer_start");
        Get.snackbar("Expired", "You can add new amount now");
      }
    });
  }

  /// ================================
  /// RESTORE TIMER
  /// ================================
  void restoreTimer() {
    final savedTime = getBox.read("timer_start");

    if (savedTime != null) {
      final start = DateTime.fromMillisecondsSinceEpoch(savedTime);
      final diff = DateTime.now().difference(start).inSeconds;

      if (diff < 600) {
        remainingSeconds.value = 600 - diff;
        isTimerActive.value = true;

        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (remainingSeconds.value > 0) {
            remainingSeconds.value--;
          } else {
            timer.cancel();
            isTimerActive.value = false;
            getBox.remove("timer_start");
          }
        });
      } else {
        getBox.remove("timer_start");
      }
    }
  }

  String get timeText {
    int min = remainingSeconds.value ~/ 60;
    int sec = remainingSeconds.value % 60;
    return "$min:${sec.toString().padLeft(2, '0')}";
  }

  @override
  void onInit() {
    super.onInit();
    restoreTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    amountController.dispose();
    transactionIdController.dispose();
    super.onClose();
  }
}
