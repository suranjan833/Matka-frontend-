import 'package:flutter/material.dart';

enum BetTypeCategory {
  singleDigit,
  singleDigitBulk,
  jodiDigits,
  jodiDigitsBulk,
  singlePana,
  singlePanaBulk,
  doublePana,
  doublePanaBulk,
  triplePana,
  sangram,
  spMotor,
  jodiPana,
  jodiPanaBulk,
  oddEven,
  bigSmall,
  halfSangam,
  fullSangam,
  motor,
}

extension BetTypeCategoryExtension on BetTypeCategory {
  String get displayName {
    switch (this) {
      case BetTypeCategory.singleDigit:
        return 'Single Digit';
      case BetTypeCategory.singleDigitBulk:
        return 'Single Digit Bulk';
      case BetTypeCategory.jodiDigits:
        return 'Jodi Digits';
      case BetTypeCategory.jodiDigitsBulk:
        return 'Jodi Digits Bulk';
      case BetTypeCategory.singlePana:
        return 'Single Pana';
      case BetTypeCategory.singlePanaBulk:
        return 'Single Pana Bulk';
      case BetTypeCategory.doublePana:
        return 'Double Pana';
      case BetTypeCategory.doublePanaBulk:
        return 'Double Pana Bulk';
      case BetTypeCategory.triplePana:
        return 'Triple Pana';
      case BetTypeCategory.sangram:
        return 'Sangram';
      case BetTypeCategory.spMotor:
        return 'SP Motor';
      case BetTypeCategory.jodiPana:
        return 'Jodi Pana';
      case BetTypeCategory.jodiPanaBulk:
        return 'Jodi Pana Bulk';
      case BetTypeCategory.oddEven:
        return 'Odd / Even';
      case BetTypeCategory.bigSmall:
        return 'Big / Small';
      case BetTypeCategory.halfSangam:
        return 'Half Sangam';
      case BetTypeCategory.fullSangam:
        return 'Full Sangam';
      case BetTypeCategory.motor:
        return 'Motor';
    }
  }

  String get subtitle {
    switch (this) {
      case BetTypeCategory.singleDigit:
        return 'Bet on a single digit 0-9';
      case BetTypeCategory.singleDigitBulk:
        return 'Bet on multiple digits at once';
      case BetTypeCategory.jodiDigits:
        return 'Bet on a pair 00-99';
      case BetTypeCategory.jodiDigitsBulk:
        return 'Bet on multiple Jodis at once';
      case BetTypeCategory.singlePana:
        return '3 unique digits (all different)';
      case BetTypeCategory.singlePanaBulk:
        return 'Bet on multiple Single Panas';
      case BetTypeCategory.doublePana:
        return '3 digits with one repeated';
      case BetTypeCategory.doublePanaBulk:
        return 'Bet on multiple Double Panas';
      case BetTypeCategory.triplePana:
        return '3 identical digits (111, 222...)';
      case BetTypeCategory.sangram:
        return 'Special Sangram bet';
      case BetTypeCategory.spMotor:
        return 'Special SP Motor bet';
      case BetTypeCategory.jodiPana:
        return 'Jodi (2-digit) + Pana (3-digit) combo';
      case BetTypeCategory.jodiPanaBulk:
        return 'Bet on multiple Jodi Pana combos';
      case BetTypeCategory.oddEven:
        return 'Bet on Odd or Even result';
      case BetTypeCategory.bigSmall:
        return 'Bet on Big (5-9) or Small (0-4)';
      case BetTypeCategory.halfSangam:
        return 'Open/Close + Pana combination';
      case BetTypeCategory.fullSangam:
        return 'Full opening & closing combo';
      case BetTypeCategory.motor:
        return 'Special Motor bet';
    }
  }

  IconData get icon {
    switch (this) {
      case BetTypeCategory.singleDigit:
        return Icons.looks_one_rounded;
      case BetTypeCategory.singleDigitBulk:
        return Icons.filter_1_rounded;
      case BetTypeCategory.jodiDigits:
        return Icons.looks_two_rounded;
      case BetTypeCategory.jodiDigitsBulk:
        return Icons.filter_2_rounded;
      case BetTypeCategory.singlePana:
        return Icons.looks_3_rounded;
      case BetTypeCategory.singlePanaBulk:
        return Icons.filter_3_rounded;
      case BetTypeCategory.doublePana:
        return Icons.repeat_rounded;
      case BetTypeCategory.doublePanaBulk:
        return Icons.repeat_one_rounded;
      case BetTypeCategory.triplePana:
        return Icons.filter_9_plus_rounded;
      case BetTypeCategory.sangram:
        return Icons.emoji_events_rounded;
      case BetTypeCategory.spMotor:
        return Icons.speed_rounded;
      case BetTypeCategory.jodiPana:
        return Icons.link_rounded;
      case BetTypeCategory.jodiPanaBulk:
        return Icons.list_alt_rounded;
      case BetTypeCategory.oddEven:
        return Icons.swap_horiz_rounded;
      case BetTypeCategory.bigSmall:
        return Icons.compare_arrows_rounded;
      case BetTypeCategory.halfSangam:
        return Icons.hub_rounded;
      case BetTypeCategory.fullSangam:
        return Icons.bluetooth_connected_rounded;
      case BetTypeCategory.motor:
        return Icons.electric_moped_rounded;
    }
  }

  Color get color {
    switch (this) {
      case BetTypeCategory.singleDigit:
        return const Color(0xff1673E6);
      case BetTypeCategory.singleDigitBulk:
        return const Color(0xff0EA5E9);
      case BetTypeCategory.jodiDigits:
        return const Color(0xff22C55E);
      case BetTypeCategory.jodiDigitsBulk:
        return const Color(0xff10B981);
      case BetTypeCategory.singlePana:
        return const Color(0xffF59E0B);
      case BetTypeCategory.singlePanaBulk:
        return const Color(0xffF97316);
      case BetTypeCategory.doublePana:
        return const Color(0xffEF4444);
      case BetTypeCategory.doublePanaBulk:
        return const Color(0xffDC2626);
      case BetTypeCategory.triplePana:
        return const Color(0xff8B5CF6);
      case BetTypeCategory.sangram:
        return const Color(0xffEC4899);
      case BetTypeCategory.spMotor:
        return const Color(0xff6366F1);
      case BetTypeCategory.jodiPana:
        return const Color(0xffD946EF);
      case BetTypeCategory.jodiPanaBulk:
        return const Color(0xffC026D3);
      case BetTypeCategory.oddEven:
        return const Color(0xff14B8A6);
      case BetTypeCategory.bigSmall:
        return const Color(0xffF97316);
      case BetTypeCategory.halfSangam:
        return const Color(0xff8B5CF6);
      case BetTypeCategory.fullSangam:
        return const Color(0xffE11D48);
      case BetTypeCategory.motor:
        return const Color(0xff059669);
    }
  }

  String get inputHint {
    switch (this) {
      case BetTypeCategory.singleDigit:
        return 'Tap a digit 0-9';
      case BetTypeCategory.singleDigitBulk:
        return 'e.g. 1,3,5,7';
      case BetTypeCategory.jodiDigits:
        return 'Enter 00-99';
      case BetTypeCategory.jodiDigitsBulk:
        return 'e.g. 12,34,56';
      case BetTypeCategory.singlePana:
        return '3 unique digits (e.g. 123)';
      case BetTypeCategory.singlePanaBulk:
        return 'e.g. 123,456,789';
      case BetTypeCategory.doublePana:
        return '3 digits with repeat (e.g. 112)';
      case BetTypeCategory.doublePanaBulk:
        return 'e.g. 112,334,565';
      case BetTypeCategory.triplePana:
        return '3 same digits (e.g. 111)';
      case BetTypeCategory.sangram:
        return 'Enter Sangram number';
      case BetTypeCategory.spMotor:
        return 'Enter SP Motor number';
      case BetTypeCategory.jodiPana:
        return '5-digit Jodi+Pana (e.g. 12123)';
      case BetTypeCategory.jodiPanaBulk:
        return 'e.g. 12123,45210,89345';
      case BetTypeCategory.oddEven:
        return 'Type "odd" or "even"';
      case BetTypeCategory.bigSmall:
        return 'Type "big" or "small"';
      case BetTypeCategory.halfSangam:
        return 'Enter Half Sangam number';
      case BetTypeCategory.fullSangam:
        return 'Enter Full Sangam number';
      case BetTypeCategory.motor:
        return 'Enter Motor number';
    }
  }

  bool get isBulkType {
    switch (this) {
      case BetTypeCategory.singleDigitBulk:
      case BetTypeCategory.jodiDigitsBulk:
      case BetTypeCategory.singlePanaBulk:
      case BetTypeCategory.doublePanaBulk:
      case BetTypeCategory.jodiPanaBulk:
        return true;
      default:
        return false;
    }
  }

  bool get isSingleDigitSelect {
    return this == BetTypeCategory.singleDigit;
  }

  bool get isToggleSelection {
    return this == BetTypeCategory.oddEven || this == BetTypeCategory.bigSmall;
  }

  bool get isPanaSelect {
    switch (this) {
      case BetTypeCategory.singlePana:
      case BetTypeCategory.singlePanaBulk:
      case BetTypeCategory.doublePana:
      case BetTypeCategory.doublePanaBulk:
      case BetTypeCategory.triplePana:
        return true;
      default:
        return false;
    }
  }

  String? validate(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter a number';
    }

    switch (this) {
      case BetTypeCategory.singleDigit:
        return _validateSingleDigit(value);
      case BetTypeCategory.singleDigitBulk:
        return _validateSingleDigitBulk(value);
      case BetTypeCategory.jodiDigits:
        return _validateJodi(value);
      case BetTypeCategory.jodiDigitsBulk:
        return _validateJodiBulk(value);
      case BetTypeCategory.singlePana:
        return _validateSinglePana(value);
      case BetTypeCategory.singlePanaBulk:
        return _validateSinglePanaBulk(value);
      case BetTypeCategory.doublePana:
        return _validateDoublePana(value);
      case BetTypeCategory.doublePanaBulk:
        return _validateDoublePanaBulk(value);
      case BetTypeCategory.triplePana:
        return _validateTriplePana(value);
      case BetTypeCategory.sangram:
        return null; // Custom validation
      case BetTypeCategory.spMotor:
        return null; // Custom validation
      case BetTypeCategory.jodiPana:
        return _validateJodiPana(value);
      case BetTypeCategory.jodiPanaBulk:
        return _validateJodiPanaBulk(value);
      case BetTypeCategory.oddEven:
        return _validateOddEven(value);
      case BetTypeCategory.bigSmall:
        return _validateBigSmall(value);
      case BetTypeCategory.halfSangam:
        return null; // Custom validation
      case BetTypeCategory.fullSangam:
        return null; // Custom validation
      case BetTypeCategory.motor:
        return null; // Custom validation
    }
  }

  String? _validateSingleDigit(String value) {
    final num = int.tryParse(value);
    if (num == null || num < 0 || num > 9) {
      return 'Enter a single digit between 0-9';
    }
    return null;
  }

  String? _validateSingleDigitBulk(String value) {
    final parts = value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty);
    if (parts.isEmpty) return 'Enter at least one digit';
    for (final part in parts) {
      final num = int.tryParse(part);
      if (num == null || num < 0 || num > 9) {
        return 'Invalid digit: "$part". Use digits 0-9';
      }
    }
    return null;
  }

  String? _validateJodi(String value) {
    final clean = value.trim().padLeft(2, '0');
    final num = int.tryParse(clean);
    if (num == null || num < 0 || num > 99) {
      return 'Enter a Jodi between 00-99';
    }
    return null;
  }

  String? _validateJodiBulk(String value) {
    final parts = value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty);
    if (parts.isEmpty) return 'Enter at least one Jodi';
    for (final part in parts) {
      final clean = part.padLeft(2, '0');
      final num = int.tryParse(clean);
      if (num == null || num < 0 || num > 99) {
        return 'Invalid Jodi: "$part". Use 00-99';
      }
    }
    return null;
  }

  String? _validateSinglePana(String value) {
    final clean = value.trim().padLeft(3, '0');
    if (clean.length != 3 || int.tryParse(clean) == null) {
      return 'Enter a 3-digit number (000-999)';
    }
    final digits = clean.split('');
    if (digits.toSet().length == digits.length) {
      return null; // All distinct - valid Single Pana
    }
    return 'Single Pana requires all 3 digits to be different';
  }

  String? _validateSinglePanaBulk(String value) {
    final parts = value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty);
    if (parts.isEmpty) return 'Enter at least one Pana';
    for (final part in parts) {
      final clean = part.padLeft(3, '0');
      if (clean.length != 3 || int.tryParse(clean) == null) {
        return 'Invalid Pana: "$part". Use 3-digit numbers';
      }
      final digits = clean.split('');
      if (digits.toSet().length != digits.length) {
        return 'Invalid: "$part" is not a Single Pana (digits must be unique)';
      }
    }
    return null;
  }

  String? _validateDoublePana(String value) {
    final clean = value.trim().padLeft(3, '0');
    if (clean.length != 3 || int.tryParse(clean) == null) {
      return 'Enter a 3-digit number (000-999)';
    }
    final digits = clean.split('');
    final uniqueCount = digits.toSet().length;
    if (uniqueCount == 2) return null; // One digit repeated - valid Double Pana
    if (uniqueCount == 1) return 'This is a Triple Pana, not Double Pana';
    return 'Double Pana requires exactly 2 matching digits';
  }

  String? _validateDoublePanaBulk(String value) {
    final parts = value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty);
    if (parts.isEmpty) return 'Enter at least one Pana';
    for (final part in parts) {
      final clean = part.padLeft(3, '0');
      if (clean.length != 3 || int.tryParse(clean) == null) {
        return 'Invalid Pana: "$part". Use 3-digit numbers';
      }
      final digits = clean.split('');
      final uniqueCount = digits.toSet().length;
      if (uniqueCount != 2) {
        return 'Invalid: "$part" is not a Double Pana (exactly 2 matching digits required)';
      }
    }
    return null;
  }

  String? _validateTriplePana(String value) {
    final clean = value.trim().padLeft(3, '0');
    if (clean.length != 3 || int.tryParse(clean) == null) {
      return 'Enter a 3-digit number (000-999)';
    }
    final digits = clean.split('');
    if (digits.toSet().length == 1) return null; // All same - valid Triple Pana
    return 'Triple Pana requires all 3 digits to be the same (e.g. 111, 222)';
  }

  String? _validateJodiPana(String value) {
    final clean = value.trim().padLeft(5, '0');
    if (clean.length != 5 || int.tryParse(clean) == null) {
      return 'Enter a 5-digit number (Jodi 2-digit + Pana 3-digit, e.g. 12123)';
    }
    // First 2 digits = Jodi
    final jodi = clean.substring(0, 2);
    if (int.parse(jodi) > 99) {
      return 'Invalid Jodi in first 2 digits. Use 00-99';
    }
    // Last 3 digits = Pana
    final pana = clean.substring(2);
    if (int.parse(pana) > 999) {
      return 'Invalid Pana in last 3 digits. Use 000-999';
    }
    return null;
  }

  String? _validateJodiPanaBulk(String value) {
    final parts = value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty);
    if (parts.isEmpty) return 'Enter at least one Jodi Pana';
    for (final part in parts) {
      final clean = part.padLeft(5, '0');
      if (clean.length != 5 || int.tryParse(clean) == null) {
        return 'Invalid entry: "$part". Use 5-digit numbers (e.g. 12123)';
      }
      final jodi = clean.substring(0, 2);
      if (int.parse(jodi) > 99) {
        return 'Invalid Jodi in "$part". Use 00-99 for first 2 digits';
      }
      final pana = clean.substring(2);
      if (int.parse(pana) > 999) {
        return 'Invalid Pana in "$part". Use 000-999 for last 3 digits';
      }
    }
    return null;
  }

  String? _validateOddEven(String value) {
    final clean = value.trim().toLowerCase();
    if (clean != 'odd' && clean != 'even') {
      return 'Type "odd" or "even"';
    }
    return null;
  }

  String? _validateBigSmall(String value) {
    final clean = value.trim().toLowerCase();
    if (clean != 'big' && clean != 'small') {
      return 'Type "big" or "small"';
    }
    return null;
  }
}
