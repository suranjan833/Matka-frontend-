import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AddFund/views/add_fund_view.dart';
import '../ManualDeposit/views/manual_deposit_view.dart';
import '../WithdrawFunds/views/withdraw_funds_view.dart';
import '../DepositHistory/views/deposit_history_view.dart';
import '../WithdrawalHistory/views/withdrawal_history_view.dart';
import '../AddBankDetails/views/add_bank_details_view.dart';

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
        Get.to(() => const AddFundView());
        break;

      case 1:
        Get.to(() => const ManualDepositView());
        break;

      case 2:
        Get.to(() => const WithdrawFundsView());
        break;

      case 3:
        Get.to(() => const DepositHistoryView());
        break;

      case 4:
        Get.to(() => const WithdrawalHistoryView());
        break;

      case 5:
        Get.to(() => const AddBankDetailsView());
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
