import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../data/sample_data.dart';

class DemoDataHelper {
  static void addDemoDataToCart(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final sampleBurgers = SampleData.getBurgers();

    // Add a few sample burgers to cart for demo purposes
    if (sampleBurgers.isNotEmpty) {
      cartProvider.addItem(sampleBurgers[0]); // Big Classic
      if (sampleBurgers.length > 1) {
        cartProvider.addItem(sampleBurgers[1]); // Quarter Pounder
      }
      if (sampleBurgers.length > 2) {
        cartProvider.addItem(sampleBurgers[2]); // Crispy Chicken Supreme
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Demo burgers added to cart!'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}