// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/add_money/bindings/add_money_binding.dart';
import '../modules/add_money/views/add_money_view.dart';
import '../modules/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/bottom_navigation/views/bottom_navigation_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/result_page/bindings/result_page_binding.dart';
import '../modules/result_page/views/result_page_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/withdraw_page/bindings/withdraw_page_binding.dart';
import '../modules/withdraw_page/views/withdraw_page_view.dart';

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
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => BottomNavigationView(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MONEY,
      page: () => const AddMoneyView(),
      binding: AddMoneyBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_PAGE,
      page: () => const WithdrawPageView(),
      binding: WithdrawPageBinding(),
    ),
    GetPage(
      name: _Paths.RESULT_PAGE,
      page: () => const ResultPageView(),
      binding: ResultPageBinding(),
    ),
  ];
}
