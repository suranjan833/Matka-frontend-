class TransactionModel {
  final String type;
  final double amount;
  final int status;
  final String statusText;
  final String note;
  final String method;
  final String date;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.status,
    required this.statusText,
    required this.note,
    required this.method,
    required this.date,
  });

  bool get isDeposit => type == 'deposit';
  bool get isWithdrawal => type == 'withdrawal';
  bool get isBet => type == 'bet';
  bool get isPending => status == 0;
  bool get isApproved => status == 1;
  bool get isRejected => status == 2;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      type: json['type'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? 0,
      statusText: json['status_text'] ?? 'Pending',
      note: json['note'] ?? '',
      method: json['method'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'status': status,
      'status_text': statusText,
      'note': note,
      'method': method,
      'date': date,
    };
  }

  /// Convert to view model map for existing UI patterns
  Map<String, dynamic> toDepositViewModel() {
    return {
      'amount': amount.toInt(),
      'method': method,
      'status': isApproved ? 'Completed' : isPending ? 'Pending' : 'Failed',
      'date': date.split(',').first.trim(),
      'time': date.contains(',') ? date.split(',').last.trim() : '',
      'txnId': note,
    };
  }

  /// Convert to withdrawal view model
  Map<String, dynamic> toWithdrawalViewModel() {
    return {
      'amount': amount.toInt(),
      'method': method,
      'status': isApproved ? 'Completed' : isPending ? 'Pending' : 'Failed',
      'date': date.split(',').first.trim(),
      'time': date.contains(',') ? date.split(',').last.trim() : '',
      'bank': note.isNotEmpty ? note : method,
    };
  }

  /// Convert to history/bet view model
  Map<String, dynamic> toBetViewModel() {
    return {
      'game': note.isNotEmpty ? note.split(' - ').first : '',
      'type': method == 'Game Bet' ? 'Bet' : method,
      'value': note.contains('(') ? note.split('(').last.replaceAll(')', '') : '',
      'amount': amount,
      'profit': isApproved ? amount * 9 : -amount, // Approximate profit
      'status': isApproved ? 'Won' : isPending ? 'Pending' : 'Lost',
      'date': date.split(',').first.trim(),
      'time': date.contains(',') ? date.split(',').last.trim() : '',
    };
  }
}
