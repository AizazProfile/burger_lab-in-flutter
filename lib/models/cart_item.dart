import 'burger.dart';

class CartItem {
  final String id;
  final Burger burger;
  int quantity;
  final List<String> customizations;

  CartItem({
    required this.id,
    required this.burger,
    this.quantity = 1,
    this.customizations = const [],
  });

  double get totalPrice => burger.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'burger': burger.toMap(),
      'quantity': quantity,
      'customizations': customizations,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      burger: Burger.fromMap(map['burger']),
      quantity: map['quantity'] ?? 1,
      customizations: List<String>.from(map['customizations'] ?? []),
    );
  }

  CartItem copyWith({
    String? id,
    Burger? burger,
    int? quantity,
    List<String>? customizations,
  }) {
    return CartItem(
      id: id ?? this.id,
      burger: burger ?? this.burger,
      quantity: quantity ?? this.quantity,
      customizations: customizations ?? this.customizations,
    );
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CartItem(id: $id, burger: ${burger.name}, quantity: $quantity, total: \$${totalPrice.toStringAsFixed(2)})';
  }
}