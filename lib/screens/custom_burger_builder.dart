import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/ingredient.dart';
import '../data/sample_data.dart';
import '../providers/cart_provider.dart';
import '../models/burger.dart';

class CustomBurgerBuilder extends StatefulWidget {
  const CustomBurgerBuilder({super.key});

  @override
  State<CustomBurgerBuilder> createState() => _CustomBurgerBuilderState();
}

class _CustomBurgerBuilderState extends State<CustomBurgerBuilder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Ingredient> selectedIngredients = [];
  final allIngredients = SampleData.getIngredients();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double get totalPrice {
    return selectedIngredients.fold(0.0, (sum, ingredient) => sum + ingredient.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Your Burger'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Buns', icon: Icon(Icons.bakery_dining, size: 20)),
            Tab(text: 'Patties', icon: Icon(Icons.lunch_dining, size: 20)),
            Tab(text: 'Cheese', icon: Icon(Icons.local_pizza, size: 20)),
            Tab(text: 'Veggies', icon: Icon(Icons.eco, size: 20)),
            Tab(text: 'Sauces', icon: Icon(Icons.colorize, size: 20)),
            Tab(text: 'Extras', icon: Icon(Icons.add_circle, size: 20)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Burger Preview
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange.shade100, Colors.white],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Custom Burger',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms),

                const SizedBox(height: 16),

                // Burger Stack Visualization
                SizedBox(
                  width: 150,
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Base plate
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 160,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      // Stacked ingredients
                      ...selectedIngredients.asMap().entries.map(
                            (entry) {
                          final index = entry.key;
                          final ingredient = entry.value;
                          return Positioned(
                            bottom: 10 + (index * 8.0),
                            child: Container(
                              width: 120 - (index * 2.0),
                              height: 20,
                              decoration: BoxDecoration(
                                color: _getIngredientColor(ingredient.type),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  ingredient.image,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .scale(delay: Duration(milliseconds: 200 * index), duration: 400.ms)
                              .then()
                              .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1), duration: 200.ms)
                              .then()
                              .scale(begin: const Offset(1.1, 1.1), end: const Offset(1.0, 1.0), duration: 200.ms);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Price Display
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Total: \$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms)
                    .scale(begin: const Offset(0.8, 0.8)),
              ],
            ),
          ),

          // Ingredients Tabs
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildIngredientsGrid(IngredientType.bun),
                _buildIngredientsGrid(IngredientType.patty),
                _buildIngredientsGrid(IngredientType.cheese),
                _buildIngredientsGrid(IngredientType.vegetable),
                _buildIngredientsGrid(IngredientType.sauce),
                _buildIngredientsGrid(IngredientType.extra),
              ],
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: selectedIngredients.isEmpty ? null : _clearBurger,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Clear All'),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: selectedIngredients.isEmpty ? null : _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Add to Cart (\$${totalPrice.toStringAsFixed(2)})',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 900.ms, duration: 600.ms)
              .slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildIngredientsGrid(IngredientType type) {
    final ingredients = allIngredients.where((ingredient) => ingredient.type == type).toList();

    if (ingredients.isEmpty) {
      return const Center(
        child: Text('No ingredients available for this category'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        final isSelected = selectedIngredients.contains(ingredient);

        return Card(
          elevation: isSelected ? 8 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? Colors.orange : Colors.transparent,
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: () => _toggleIngredient(ingredient),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected ? Colors.orange.shade50 : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _getIngredientColor(ingredient.type).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        ingredient.image,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    ingredient.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '\$${ingredient.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Added',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        .animate()
                        .scale(delay: 100.ms, duration: 300.ms)
                        .fadeIn(),
                ],
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 200 + (index * 100)), duration: 400.ms)
            .slideY(begin: 0.2, end: 0);
      },
    );
  }

  void _toggleIngredient(Ingredient ingredient) {
    setState(() {
      if (selectedIngredients.contains(ingredient)) {
        selectedIngredients.remove(ingredient);
      } else {
        // For buns and patties, allow only one at a time
        if (ingredient.type == IngredientType.bun) {
          selectedIngredients.removeWhere((item) => item.type == IngredientType.bun);
        } else if (ingredient.type == IngredientType.patty) {
          selectedIngredients.removeWhere((item) => item.type == IngredientType.patty);
        }
        selectedIngredients.add(ingredient);
      }
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          selectedIngredients.contains(ingredient)
              ? '${ingredient.name} added!'
              : '${ingredient.name} removed!',
        ),
        backgroundColor: selectedIngredients.contains(ingredient) ? Colors.green : Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _clearBurger() {
    setState(() {
      selectedIngredients.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Burger cleared!'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addToCart() {
    if (selectedIngredients.isEmpty) return;

    // Create a custom burger
    final customBurger = Burger(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Custom Burger',
      description: 'Your custom creation with ${selectedIngredients.map((e) => e.name).join(', ')}',
      price: totalPrice,
      image: '🍔',
      category: 'Custom',
      ingredients: selectedIngredients.map((e) => e.name).toList(),
    );

    // Add to cart
    Provider.of<CartProvider>(context, listen: false).addItem(
      customBurger,
      customizations: selectedIngredients.map((e) => e.name).toList(),
    );

    // Show success message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🎉 Burger Added!'),
          content: Text(
            'Your custom burger has been added to your cart!\n\nTotal: \$${totalPrice.toStringAsFixed(2)}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  selectedIngredients.clear();
                });
              },
              child: const Text('Build Another'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/cart');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text(
                'View Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getIngredientColor(IngredientType type) {
    switch (type) {
      case IngredientType.bun:
        return Colors.brown.shade300;
      case IngredientType.patty:
        return Colors.brown.shade600;
      case IngredientType.cheese:
        return Colors.yellow.shade600;
      case IngredientType.vegetable:
        return Colors.green.shade400;
      case IngredientType.sauce:
        return Colors.red.shade400;
      case IngredientType.extra:
        return Colors.orange.shade400;
    }
  }
}