class FoodModel {
  final String id;
  final String name;
  final String details;
  final String image;
  final String price;

  FoodModel({
    required this.id,
    required this.name,
    required this.details,
    required this.image,
    required this.price,
  });

  factory FoodModel.fromFirestore(Map<String, dynamic> map, String id) {
    return FoodModel(
      id: id,
      name: map['name'] ?? '',
      details: map['details'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'details': details,
      'image': image,
      'price': price,
    };
  }
}