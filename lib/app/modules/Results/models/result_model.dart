class ResultModel {
  final int id;
  final String market;
  final String session;
  final int gameType;
  final String result;
  final String date;

  ResultModel({
    required this.id,
    required this.market,
    required this.session,
    required this.gameType,
    required this.result,
    required this.date,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'] ?? 0,
      market: json['market'] ?? '',
      session: json['session'] ?? '',
      gameType: json['game_type'] ?? 0,
      result: json['result'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'market': market,
      'session': session,
      'game_type': gameType,
      'result': result,
      'date': date,
    };
  }

  /// Convert to view model map for existing UI
  Map<String, dynamic> toViewModel() {
    return {
      'game': market,
      'open': result,
      'close': '',
      'date': date.split(',').first.trim(),
    };
  }
}
