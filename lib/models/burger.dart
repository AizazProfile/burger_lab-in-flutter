class Burger {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final List<String> ingredients;

  Burger({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.ingredients,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'ingredients': ingredients,
    };
  }

  factory Burger.fromMap(Map<String, dynamic> map) {
    return Burger(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
    );
  }

  Burger copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? image,
    String? category,
    List<String>? ingredients,
  }) {
    return Burger(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Burger && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Burger(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }
}