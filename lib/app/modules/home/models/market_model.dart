class MarketModel {
  final int id;
  final String name;
  final String startTime;
  final String endTime;
  final String time;
  final String status;

  MarketModel({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.time,
    required this.status,
  });

  bool get isOpen => status.toLowerCase() == 'open';

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? 'Closed',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_time': startTime,
      'end_time': endTime,
      'time': time,
      'status': status,
    };
  }

  /// Convert to the map format used by views
  Map<String, dynamic> toViewModel() {
    return {
      'name': name,
      'result': '',
      'status': isOpen ? 'Open' : 'Betting Is Closed For Today',
      'openTime': startTime,
      'closeTime': endTime,
    };
  }
}
