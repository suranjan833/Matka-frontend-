class UserModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final bool mpinSet;
  final String token;
  final double? wallet;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.mpinSet,
    required this.token,
    this.wallet,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      mpinSet: json['mpin_set'] ?? false,
      token: json['token'] ?? '',
      wallet: (json['wallet'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'mpin_set': mpinSet,
      'token': token,
      'wallet': wallet,
    };
  }
}
