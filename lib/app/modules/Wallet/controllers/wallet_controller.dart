import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  RxDouble walletBalance = 0.0.obs;

  final RxList<WalletMenuModel> walletMenus = <WalletMenuModel>[
    WalletMenuModel(
      title: "Add Fund",
      color: const Color(0xff22C55E),
      icon: Icons.add_card_rounded,
    ),
    WalletMenuModel(
      title: "Manual Deposit Upload Image",
      color: const Color(0xffEAB308),
      icon: Icons.account_balance_rounded,
    ),
    WalletMenuModel(
      title: "Withdraw Funds",
      color: const Color(0xff0EA5E9),
      icon: Icons.payments_outlined,
    ),
    WalletMenuModel(
      title: "Deposit History",
      color: const Color(0xff06B6D4),
      icon: Icons.calendar_month_outlined,
    ),
    WalletMenuModel(
      title: "Withdrawal History",
      color: const Color(0xff4361EE),
      icon: Icons.receipt_long_outlined,
    ),
    WalletMenuModel(
      title: "Add Bank Details",
      color: const Color(0xff9333EA),
      icon: Icons.account_balance_outlined,
    ),
  ].obs;

  void onMenuTap(int index) {
    switch (index) {
      case 0:
        // Get.to(() => AddFundView());
        break;

      case 1:
        // Get.to(() => UploadDepositView());
        break;

      case 2:
        // Get.to(() => WithdrawView());
        break;

      case 3:
        // Get.to(() => DepositHistoryView());
        break;

      case 4:
        // Get.to(() => WithdrawalHistoryView());
        break;

      case 5:
        // Get.to(() => AddBankView());
        break;
    }
  }
}

class WalletMenuModel {
  final String title;
  final Color color;
  final IconData icon;

  WalletMenuModel({
    required this.title,
    required this.color,
    required this.icon,
  });
}
