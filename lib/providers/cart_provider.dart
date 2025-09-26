import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/burger.dart';
import '../services/storage_service.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = false;
  final StorageService _storageService = StorageService();

  List<CartItem> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await _storageService.getCart();
    } catch (e) {
      debugPrint('Error loading cart: $e');
      _items = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveCart() async {
    try {
      await _storageService.saveCart(_items);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  Future<void> addItem(Burger burger, {List<String> customizations = const []}) async {
    // Check if item already exists with same customizations
    final existingIndex = _items.indexWhere(
          (item) => item.burger.id == burger.id &&
          _listEquals(item.customizations, customizations),
    );

    if (existingIndex >= 0) {
      // Update existing item quantity
      _items[existingIndex].incrementQuantity();
    } else {
      // Add new item
      final newItem = CartItem(
        id: '${burger.id}_${DateTime.now().millisecondsSinceEpoch}',
        burger: burger,
        quantity: 1,
        customizations: customizations,
      );
      _items.add(newItem);
    }

    await saveCart();
    notifyListeners();
  }

  Future<void> removeItem(String itemId) async {
    _items.removeWhere((item) => item.id == itemId);
    await saveCart();
    notifyListeners();
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(itemId);
      return;
    }

    final itemIndex = _items.indexWhere((item) => item.id == itemId);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity = quantity;
      await saveCart();
      notifyListeners();
    }
  }

  Future<void> incrementQuantity(String itemId) async {
    final itemIndex = _items.indexWhere((item) => item.id == itemId);
    if (itemIndex >= 0) {
      _items[itemIndex].incrementQuantity();
      await saveCart();
      notifyListeners();
    }
  }

  Future<void> decrementQuantity(String itemId) async {
    final itemIndex = _items.indexWhere((item) => item.id == itemId);
    if (itemIndex >= 0) {
      if (_items[itemIndex].quantity <= 1) {
        await removeItem(itemId);
      } else {
        _items[itemIndex].decrementQuantity();
        await saveCart();
        notifyListeners();
      }
    }
  }

  Future<void> clearCart() async {
    _items.clear();
    await _storageService.clearCart();
    notifyListeners();
  }

  bool isInCart(String burgerId) {
    return _items.any((item) => item.burger.id == burgerId);
  }

  int getItemQuantity(String burgerId) {
    final item = _items.firstWhere(
          (item) => item.burger.id == burgerId,
      orElse: () => CartItem(
        id: '',
        burger: Burger(
          id: '',
          name: '',
          description: '',
          price: 0,
          image: '',
          category: '',
          ingredients: [],
        ),
        quantity: 0,
      ),
    );
    return item.quantity;
  }

  // Helper method to compare lists
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    if (identical(a, b)) return true;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }

  // Calculate discount if applicable
  double get discount {
    if (totalAmount > 50) return totalAmount * 0.1; // 10% discount for orders over $50
    if (totalAmount > 30) return totalAmount * 0.05; // 5% discount for orders over $30
    return 0;
  }

  double get finalAmount => totalAmount - discount;
}