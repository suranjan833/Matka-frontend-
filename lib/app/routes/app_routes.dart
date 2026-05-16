// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN_PAGE = _Paths.LOGIN_PAGE;
  static const SIGN_UP = _Paths.SIGN_UP;
  static const BOTTOM_NAVIGATION = _Paths.BOTTOM_NAVIGATION;
  static const ADD_MONEY = _Paths.ADD_MONEY;
  static const WITHDRAW_PAGE = _Paths.WITHDRAW_PAGE;
  static const RESULT_PAGE = _Paths.RESULT_PAGE;
  static const BAZAAR = _Paths.BAZAAR;
  static const GAMETYPES = _Paths.GAMETYPES;
  static const PLACE_BET = _Paths.PLACE_BET;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN_PAGE = '/login-page';
  static const SIGN_UP = '/sign-up';
  static const BOTTOM_NAVIGATION = '/bottom-navigation';
  static const ADD_MONEY = '/add-money';
  static const WITHDRAW_PAGE = '/withdraw-page';
  static const RESULT_PAGE = '/result-page';
  static const BAZAAR = '/bazaar';
  static const GAMETYPES = '/gametypes';
  static const PLACE_BET = '/place-bet';
}
