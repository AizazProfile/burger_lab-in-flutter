class BurgerCategory {
  final String id;
  final String name;
  final String description;
  final String image;
  final int itemCount;

  BurgerCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.itemCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'itemCount': itemCount,
    };
  }

  factory BurgerCategory.fromMap(Map<String, dynamic> map) {
    return BurgerCategory(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      itemCount: map['itemCount'] ?? 0,
    );
  }

  BurgerCategory copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    int? itemCount,
  }) {
    return BurgerCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BurgerCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'BurgerCategory(id: $id, name: $name, items: $itemCount)';
  }
}