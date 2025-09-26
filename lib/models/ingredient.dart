enum IngredientType {
  bun,
  patty,
  cheese,
  vegetable,
  sauce,
  extra,
}

class Ingredient {
  final String id;
  final String name;
  final IngredientType type;
  final double price;
  final String image;
  final String description;

  Ingredient({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'price': price,
      'image': image,
      'description': description,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: IngredientType.values.firstWhere(
            (e) => e.name == map['type'],
        orElse: () => IngredientType.extra,
      ),
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Ingredient copyWith({
    String? id,
    String? name,
    IngredientType? type,
    double? price,
    String? image,
    String? description,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ingredient && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Ingredient(id: $id, name: $name, type: ${type.name}, price: \$${price.toStringAsFixed(2)})';
  }
}

class CustomBurger {
  final String id;
  final String name;
  final List<Ingredient> ingredients;

  CustomBurger({
    required this.id,
    required this.name,
    required this.ingredients,
  });

  double get totalPrice => ingredients.fold(0.0, (sum, ingredient) => sum + ingredient.price);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients.map((ingredient) => ingredient.toMap()).toList(),
    };
  }

  factory CustomBurger.fromMap(Map<String, dynamic> map) {
    return CustomBurger(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      ingredients: List<Ingredient>.from(
        (map['ingredients'] ?? []).map((x) => Ingredient.fromMap(x)),
      ),
    );
  }

  CustomBurger copyWith({
    String? id,
    String? name,
    List<Ingredient>? ingredients,
  }) {
    return CustomBurger(
      id: id ?? this.id,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  @override
  String toString() {
    return 'CustomBurger(id: $id, name: $name, total: \$${totalPrice.toStringAsFixed(2)})';
  }
}