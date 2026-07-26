import 'package:intl/intl.dart';

class MarketTimeResult {
  final bool canBet;
  final String message;

  MarketTimeResult({required this.canBet, required this.message});

  static final canBetResult = MarketTimeResult(canBet: true, message: '');
  static final closedResult = MarketTimeResult(
    canBet: false,
    message: 'Market is closed for today',
  );
}

class MarketTimeUtils {
  static const int _closeBufferMinutes = 2;

  /// Parses a time string like "9:40 AM" or "10:40 AM" into a DateTime
  /// with today's date. Returns null if parsing fails.
  static DateTime? _parseTimeToToday(String timeStr) {
    try {
      final now = DateTime.now();
      final parsed = DateFormat('h:mm a').parse(timeStr);
      return DateTime(
        now.year,
        now.month,
        now.day,
        parsed.hour,
        parsed.minute,
      );
    } catch (_) {
      return null;
    }
  }

  /// Checks if the current time falls within the market's active window.
  ///
  /// Rules:
  /// 1. Market must be "Open" (status not containing "Closed")
  /// 2. Current time must be between openTime and closeTime
  /// 3. If current time is within [closeBufferMinutes] of closing, betting is blocked
  ///
  /// [market] should contain keys: 'status', 'openTime', 'closeTime'
  static MarketTimeResult canPlaceBet(Map<String, dynamic> market) {
    final now = DateTime.now();

    // Rule 1: Check market status
    final status = (market['status'] as String? ?? '');
    if (status.toLowerCase().contains('closed')) {
      return MarketTimeResult.closedResult;
    }

    // Rule 2 & 3: Parse and compare times
    final openTimeStr = market['openTime'] as String? ?? '';
    final closeTimeStr = market['closeTime'] as String? ?? '';

    if (openTimeStr.isEmpty || closeTimeStr.isEmpty) {
      return MarketTimeResult.closedResult;
    }

    final openDt = _parseTimeToToday(openTimeStr);
    final closeDt = _parseTimeToToday(closeTimeStr);

    if (openDt == null || closeDt == null) {
      return MarketTimeResult.closedResult;
    }

    // Not yet open
    if (now.isBefore(openDt)) {
      final formatter = DateFormat('h:mm a');
      return MarketTimeResult(
        canBet: false,
        message: 'Market opens at ${formatter.format(openDt)}',
      );
    }

    // Within 2-minute buffer before closing
    final bufferDt = closeDt.subtract(Duration(minutes: _closeBufferMinutes));
    if (now.isAfter(bufferDt) && now.isBefore(closeDt)) {
      return MarketTimeResult(
        canBet: false,
        message:
            'Betting closed — market closes in less than $_closeBufferMinutes minutes',
      );
    }

    // After closing
    if (now.isAfter(closeDt) || now.isAtSameMomentAs(closeDt)) {
      return MarketTimeResult.closedResult;
    }

    return MarketTimeResult.canBetResult;
  }
}
