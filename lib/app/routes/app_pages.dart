import 'package:get/get.dart';

import '../modules/AllBids/bindings/all_bids_binding.dart';
import '../modules/AllBids/views/all_bids_view.dart';
import '../modules/BottomNavigation/bindings/bottom_navigation_binding.dart';
import '../modules/BottomNavigation/views/bottom_navigation_view.dart';
import '../modules/LoginPage/bindings/login_page_binding.dart';
import '../modules/LoginPage/views/login_page_view.dart';
import '../modules/MpinLogin/bindings/mpin_login_binding.dart';
import '../modules/MpinLogin/views/mpin_login_view.dart';
import '../modules/SignUpView/bindings/sign_up_view_binding.dart';
import '../modules/SignUpView/views/sign_up_view_view.dart';
import '../modules/Wallet/bindings/wallet_binding.dart';
import '../modules/Wallet/views/wallet_view.dart';
import '../modules/Wallet/AddFund/bindings/add_fund_binding.dart';
import '../modules/Wallet/AddFund/views/add_fund_view.dart';
import '../modules/Wallet/ManualDeposit/bindings/manual_deposit_binding.dart';
import '../modules/Wallet/ManualDeposit/views/manual_deposit_view.dart';
import '../modules/Wallet/WithdrawFunds/bindings/withdraw_funds_binding.dart';
import '../modules/Wallet/WithdrawFunds/views/withdraw_funds_view.dart';
import '../modules/Wallet/DepositHistory/bindings/deposit_history_binding.dart';
import '../modules/Wallet/DepositHistory/views/deposit_history_view.dart';
import '../modules/Wallet/WithdrawalHistory/bindings/withdrawal_history_binding.dart';
import '../modules/Wallet/WithdrawalHistory/views/withdrawal_history_view.dart';
import '../modules/Wallet/AddBankDetails/bindings/add_bank_details_binding.dart';
import '../modules/Wallet/AddBankDetails/views/add_bank_details_view.dart';
import '../modules/AccountStatement/bindings/account_statement_binding.dart';
import '../modules/AccountStatement/views/account_statement_view.dart';
import '../modules/TermsConditions/bindings/terms_conditions_binding.dart';
import '../modules/TermsConditions/views/terms_conditions_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/GamePage/bindings/game_page_binding.dart';
import '../modules/GamePage/views/game_page_view.dart';
import '../modules/BetInputPage/bindings/bet_input_page_binding.dart';
import '../modules/BetInputPage/views/bet_input_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_VIEW,
      page: () => SignUpView(),
      binding: SignUpViewBinding(),
    ),
    GetPage(
      name: _Paths.MPIN_LOGIN,
      page: () => MpinLoginView(),
      binding: MpinLoginBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => const BottomNavigationView(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.ALL_BIDS,
      page: () => const AllBidsView(),
      binding: AllBidsBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.ADD_FUND,
      page: () => const AddFundView(),
      binding: AddFundBinding(),
    ),
    GetPage(
      name: _Paths.MANUAL_DEPOSIT,
      page: () => const ManualDepositView(),
      binding: ManualDepositBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_FUNDS,
      page: () => const WithdrawFundsView(),
      binding: WithdrawFundsBinding(),
    ),
    GetPage(
      name: _Paths.DEPOSIT_HISTORY,
      page: () => const DepositHistoryView(),
      binding: DepositHistoryBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAWAL_HISTORY,
      page: () => const WithdrawalHistoryView(),
      binding: WithdrawalHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BANK_DETAILS,
      page: () => const AddBankDetailsView(),
      binding: AddBankDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_STATEMENT,
      page: () => const AccountStatementView(),
      binding: AccountStatementBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITIONS,
      page: () => const TermsConditionsView(),
      binding: TermsConditionsBinding(),
    ),
    GetPage(
      name: _Paths.GAME_PAGE,
      page: () => const GamePageView(),
      binding: GamePageBinding(),
    ),
    GetPage(
      name: _Paths.BET_INPUT,
      page: () => const BetInputPageView(),
      binding: BetInputPageBinding(),
    ),
  ];
}
