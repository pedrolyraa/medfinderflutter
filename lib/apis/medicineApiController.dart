class Medicine {
  final String name;
  final String description;
  final int quantity;
  final int dailyUse;
  final int totalQuantity;
  final String type;

  Medicine({
    required this.name,
    required this.description,
    required this.quantity,
    required this.dailyUse,
    required this.totalQuantity,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'quantityML': quantity, // ou 'quantity', dependendo do que a API espera
      'dailyUse': dailyUse,
      'totalQuantity': totalQuantity,
      'type': type,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'],
      description: json['description'],
      quantity: json['quantityML'], // Mudado para 'quantityML' no JSON
      dailyUse: json['dailyUse'],
      totalQuantity: json['totalQuantity'],
      type: json['type'],
    );
  }


}
