class CartModel {
  final String name;
  final String image;
  final String quantity;
  final String total;

  CartModel({
    required this.name,
    required this.image,
    required this.quantity,
    required this.total,
  });

  factory CartModel.fromFirestore(Map<String, dynamic> map) {
    return CartModel(
      name: map['Name'] ?? '',
      image: map['Image'] ?? '',
      quantity: map['Quantity'] ?? '0',
      total: map['Total'] ?? '0',
    );
  }
}