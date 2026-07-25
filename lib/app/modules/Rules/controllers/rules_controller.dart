import 'package:get/get.dart';

class RulesController extends GetxController {
  final RxList<Map<String, dynamic>> rules = <Map<String, dynamic>>[
    {
      "title": "General Rules",
      "icon": "gavel",
      "content": [
        "Players must be 18 years or older to participate.",
        "All bets are final once placed. No cancellations or modifications.",
        "Minimum deposit amount is ₹100.",
        "Minimum withdrawal amount is ₹200.",
        "Withdrawals are processed within 24-48 hours on working days.",
        "Any fraudulent activity will result in permanent account suspension.",
        "The company reserves the right to modify rules at any time.",
        "All disputes will be resolved by the management's decision.",
      ],
    },
    {
      "title": "Single Digit (Jodi)",
      "icon": "looks_one",
      "content": [
        "Choose a single digit from 0 to 9.",
        "If your chosen digit matches the opening or closing result, you win.",
        "Payout: 9.5x your bet amount.",
        "Example: If you bet ₹100 on digit 5 and the result shows 5, you win ₹950.",
      ],
    },
    {
      "title": "Jodi (Pair)",
      "icon": "looks_two",
      "content": [
        "Choose a pair of digits from combination of first and last digit result.",
        "If both digits match the result in exact order, you win.",
        "Payout: 90x your bet amount.",
        "Example: If you bet on pair \"35\" and the result declared is \"35\", you win 90x your bet.",
      ],
    },
    {
      "title": "Single Pana",
      "icon": "looks_3",
      "content": [
        "Select any single Pana from the available list.",
        "If the Pana matches the result, you win.",
        "Payout: 140x your bet amount.",
        "Each Pana consists of a 3-digit combination.",
      ],
    },
    {
      "title": "Double Pana",
      "icon": "looks_4",
      "content": [
        "Select any Double Pana from the available list.",
        "If the Pana matches the result, you win.",
        "Payout: 280x your bet amount.",
        "Double Pana contains exactly two identical digits.",
      ],
    },
    {
      "title": "Triple Pana",
      "icon": "looks_5",
      "content": [
        "Select any Triple Pana from the available list.",
        "If the Pana matches the result, you win.",
        "Payout: 500x your bet amount.",
        "Triple Pana contains three identical digits.",
      ],
    },
    {
      "title": "Half Sangam",
      "icon": "filter_none",
      "content": [
        "Choose a combination where you pick one digit from opening and one Pana from closing (or vice versa).",
        "Payout: 120x your bet amount.",
        "Both selections must match the declared results.",
      ],
    },
    {
      "title": "Full Sangam",
      "icon": "filter_none",
      "content": [
        "Choose one Pana from opening and one Pana from closing results.",
        "Payout: 500x your bet amount.",
        "Both Pana selections must match exactly with declared results.",
      ],
    },
    {
      "title": "Result Declaration",
      "icon": "emoji_events",
      "content": [
        "Results are declared at the specified closing time for each market.",
        "Results published on the platform are final and binding.",
        "In case of technical errors, the company holds the right to void bets.",
        "All results can be viewed in the 'Results' section.",
      ],
    },
  ].obs;
}
