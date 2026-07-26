class BetHistoryModel {
  final int id;
  final String market;
  final String session;
  final int gameType;
  final String number;
  final double amount;
  final int status;
  final String statusText;
  final String date;

  BetHistoryModel({
    required this.id,
    required this.market,
    required this.session,
    required this.gameType,
    required this.number,
    required this.amount,
    required this.status,
    required this.statusText,
    required this.date,
  });

  bool get isPending => status == 0;
  bool get isWon => status == 1;
  bool get isLost => status == 2;

  double get profit => isWon ? amount * 9 : -amount;

  factory BetHistoryModel.fromJson(Map<String, dynamic> json) {
    return BetHistoryModel(
      id: json['id'] ?? 0,
      market: json['market'] ?? '',
      session: json['session'] ?? '',
      gameType: json['game_type'] ?? 0,
      number: json['number'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? 0,
      statusText: json['status_text'] ?? 'Pending',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'market': market,
      'session': session,
      'game_type': gameType,
      'number': number,
      'amount': amount,
      'status': status,
      'status_text': statusText,
      'date': date,
    };
  }

  /// Convert to view model map for existing UI
  Map<String, dynamic> toViewModel() {
    return {
      'game': market,
      'type': 'Game Type $gameType',
      'value': number,
      'amount': amount,
      'profit': profit,
      'status': isWon ? 'Won' : isLost ? 'Lost' : 'Pending',
      'date': date.split(',').first.trim(),
      'time': date.contains(',') ? date.split(',').last.trim() : '',
    };
  }
}
