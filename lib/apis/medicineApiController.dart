
class Medicine {
  // Adicione o campo id, se necessário
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
