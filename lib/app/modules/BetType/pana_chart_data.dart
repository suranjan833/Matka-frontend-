import 'package:flutter/material.dart';
import 'bet_type.dart';

class PanaFamily {
  final int digit;
  final List<String> singlePana;
  final List<String> doublePana;
  final String triplePana;

  const PanaFamily({
    required this.digit,
    required this.singlePana,
    required this.doublePana,
    required this.triplePana,
  });

  List<String> get allPana => [...singlePana, ...doublePana, triplePana];
}

class PanaChartData {
  PanaChartData._();

  /// Complete 220 Pana chart organized by family digit (0-9).
  /// Each family has 12 Single Pana + 9 Double Pana + 1 Triple Pana = 22 numbers.
  static const Map<int, PanaFamily> families = {
    0: PanaFamily(
      digit: 0,
      singlePana: ['127', '136', '145', '190', '235', '280', '370', '389', '460', '479', '569', '578'],
      doublePana: ['118', '226', '244', '299', '334', '488', '550', '668', '677'],
      triplePana: '000',
    ),
    1: PanaFamily(
      digit: 1,
      singlePana: ['128', '137', '146', '236', '245', '290', '380', '470', '489', '560', '579', '678'],
      doublePana: ['100', '119', '155', '227', '335', '344', '399', '588', '669'],
      triplePana: '777',
    ),
    2: PanaFamily(
      digit: 2,
      singlePana: ['129', '138', '147', '156', '237', '246', '345', '390', '480', '570', '589', '679'],
      doublePana: ['110', '200', '228', '255', '366', '499', '660', '688', '778'],
      triplePana: '444',
    ),
    3: PanaFamily(
      digit: 3,
      singlePana: ['120', '139', '148', '157', '238', '247', '256', '346', '490', '580', '670', '689'],
      doublePana: ['166', '229', '300', '337', '355', '445', '599', '779', '788'],
      triplePana: '111',
    ),
    4: PanaFamily(
      digit: 4,
      singlePana: ['130', '149', '158', '167', '239', '248', '257', '347', '356', '590', '680', '789'],
      doublePana: ['112', '220', '266', '338', '400', '446', '455', '699', '770'],
      triplePana: '888',
    ),
    5: PanaFamily(
      digit: 5,
      singlePana: ['140', '159', '168', '230', '249', '258', '267', '348', '357', '456', '690', '780'],
      doublePana: ['113', '122', '177', '339', '366', '447', '500', '799', '889'],
      triplePana: '555',
    ),
    6: PanaFamily(
      digit: 6,
      singlePana: ['123', '150', '169', '178', '240', '259', '268', '349', '358', '367', '457', '790'],
      doublePana: ['600', '114', '277', '330', '448', '466', '556', '880', '899'],
      triplePana: '222',
    ),
    7: PanaFamily(
      digit: 7,
      singlePana: ['124', '160', '278', '179', '250', '269', '340', '359', '368', '458', '467', '890'],
      doublePana: ['115', '133', '188', '223', '377', '449', '557', '566', '700'],
      triplePana: '999',
    ),
    8: PanaFamily(
      digit: 8,
      singlePana: ['125', '134', '170', '189', '260', '279', '350', '369', '468', '378', '459', '567'],
      doublePana: ['116', '224', '233', '288', '440', '477', '558', '800', '990'],
      triplePana: '666',
    ),
    9: PanaFamily(
      digit: 9,
      singlePana: ['126', '135', '180', '234', '270', '289', '360', '379', '450', '469', '478', '568'],
      doublePana: ['117', '144', '199', '225', '388', '559', '577', '667', '900'],
      triplePana: '333',
    ),
  };

  static const List<String> triplePanaNumbers = [
    '000', '111', '222', '333', '444', '555', '666', '777', '888', '999',
  ];

  /// Color associated with each family digit
  static Color familyColor(int digit) {
    const colors = [
      Color(0xffEF4444), // 0 - Red
      Color(0xffF59E0B), // 1 - Amber
      Color(0xff22C55E), // 2 - Green
      Color(0xff1673E6), // 3 - Blue
      Color(0xff8B5CF6), // 4 - Purple
      Color(0xffEC4899), // 5 - Pink
      Color(0xff14B8A6), // 6 - Teal
      Color(0xffF97316), // 7 - Orange
      Color(0xff6366F1), // 8 - Indigo
      Color(0xffDC2626), // 9 - Deep Red
    ];
    return colors[digit % 10];
  }

  /// Get the numbers to display for a given bet type
  static List<String> numbersForBetType(BetTypeCategory category, int familyDigit) {
    final family = families[familyDigit];
    if (family == null) return [];

    switch (category) {
      case BetTypeCategory.singlePana:
        return family.singlePana;
      case BetTypeCategory.singlePanaBulk:
        return family.singlePana;
      case BetTypeCategory.doublePana:
        return family.doublePana;
      case BetTypeCategory.doublePanaBulk:
        return family.doublePana;
      case BetTypeCategory.triplePana:
        return [triplePanaNumbers[familyDigit % 10]];
      default:
        return [];
    }
  }

  /// Get all valid numbers for a bet type across all families
  static List<String> allNumbersForBetType(BetTypeCategory category) {
    switch (category) {
      case BetTypeCategory.singlePana:
      case BetTypeCategory.singlePanaBulk:
        return families.values.expand((f) => f.singlePana).toList();
      case BetTypeCategory.doublePana:
      case BetTypeCategory.doublePanaBulk:
        return families.values.expand((f) => f.doublePana).toList();
      case BetTypeCategory.triplePana:
        return triplePanaNumbers;
      default:
        return [];
    }
  }
}
