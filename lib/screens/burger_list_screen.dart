import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/burger.dart';
import '../models/category.dart';
import '../providers/cart_provider.dart';
import '../data/sample_data.dart';

class BurgerListScreen extends StatefulWidget {
  final BurgerCategory category;

  const BurgerListScreen({
    super.key,
    required this.category,
  });

  @override
  State<BurgerListScreen> createState() => _BurgerListScreenState();
}

class _BurgerListScreenState extends State<BurgerListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<Burger> categoryBurgers = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _loadCategoryBurgers();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadCategoryBurgers() {
    // Filter burgers by category
    final allBurgers = SampleData.getBurgers();
    categoryBurgers = allBurgers
        .where((burger) => burger.category == widget.category.name)
        .toList();

    // If no burgers found, generate some sample burgers for the category
    if (categoryBurgers.isEmpty) {
      categoryBurgers = _generateSampleBurgers();
    }
  }

  List<Burger> _generateSampleBurgers() {
    // Generate sample burgers based on category
    final categoryName = widget.category.name;
    final burgers = <Burger>[];

    for (int i = 1; i <= widget.category.itemCount; i++) {
      burgers.add(Burger(
        id: '${widget.category.id}_$i',
        name: '$categoryName Special #$i',
        description: 'Delicious ${categoryName.toLowerCase()} with premium ingredients',
        price: 10.99 + (i * 2.0),
        image: 'assets/images/burger_${widget.category.id}_$i.jpg',
        category: categoryName,
        ingredients: ['Premium Bun', 'Fresh Lettuce', 'Tomato', 'Special Sauce'],
      ));
    }

    return burgers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/cart');
                    },
                  ),
                  if (cartProvider.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartProvider.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: categoryBurgers.isEmpty
          ? const Center(
              child: Text('No burgers available in this category'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categoryBurgers.length,
              itemBuilder: (context, index) {
                final burger = categoryBurgers[index];
                return BurgerCard(
                  burger: burger,
                  onAddToCart: () => _addToCart(burger),
                )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 100 + (index * 50)),
                      duration: const Duration(milliseconds: 400),
                    )
                    .slideY(begin: 0.1, end: 0);
              },
            ),
    );
  }

  void _addToCart(Burger burger) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addItem(burger);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text('${burger.name} added to cart!'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamed('/cart');
          },
        ),
      ),
    );
  }
}

class BurgerCard extends StatelessWidget {
  final Burger burger;
  final VoidCallback onAddToCart;

  const BurgerCard({
    super.key,
    required this.burger,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      shadowColor: Colors.orange.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.orange.shade50,
              ],
            ),
          ),
          child: Row(
            children: [
              // Burger Image
              Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: Image.asset(
                    burger.image,
                    width: 120,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to icon if image not found
                      return Container(
                        width: 120,
                        height: 140,
                        color: Colors.orange.shade100,
                        child: Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.fastfood,
                                size: 40,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Burger Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        burger.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        burger.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Ingredients
                      if (burger.ingredients.isNotEmpty)
                        Text(
                          'Ingredients: ${burger.ingredients.take(3).join(', ')}${burger.ingredients.length > 3 ? '...' : ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const Spacer(),

                      // Price and Add Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${burger.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: onAddToCart,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add_shopping_cart, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Add',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
