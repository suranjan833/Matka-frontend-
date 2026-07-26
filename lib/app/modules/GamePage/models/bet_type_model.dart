// TODO: This model is prepared for future API integration with get_bet_types.php
// Currently the app uses hardcoded BetTypeCategory enum for bet types.
// When get_bet_types.php API is integrated, use this model to parse the response.
//
// API response format (from app_documentation.md):
// {
//   "status": 200,
//   "message": "Success",
//   "data": [
//     {"id": 1, "name": "Single Digit", "format": "1 digit (0-9)", "type": "digit", "digits": 1},
//     ...
//   ]
// }

class BetTypeModel {
  final int id;
  final String name;
  final String format;
  final String inputType;
  final int digits;

  BetTypeModel({
    required this.id,
    required this.name,
    required this.format,
    required this.inputType,
    required this.digits,
  });

  factory BetTypeModel.fromJson(Map<String, dynamic> json) {
    return BetTypeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      format: json['format'] ?? '',
      inputType: json['type'] ?? 'digit',
      digits: json['digits'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'format': format,
      'type': inputType,
      'digits': digits,
    };
  }
}
