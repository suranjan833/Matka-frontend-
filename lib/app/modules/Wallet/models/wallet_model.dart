// TODO: This model is available for refactoring WalletController
// to use typed models instead of raw Map access.

class WalletModel {
  final double balance;

  WalletModel({required this.balance});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: (json['balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'balance': balance};
  }
}
