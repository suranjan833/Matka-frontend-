class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final double wallet;
  final bool mpinSet;
  final int status;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.wallet,
    required this.mpinSet,
    required this.status,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      wallet: (json['wallet'] ?? 0).toDouble(),
      mpinSet: json['mpin_set'] ?? false,
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'wallet': wallet,
      'mpin_set': mpinSet,
      'status': status,
    };
  }
}
