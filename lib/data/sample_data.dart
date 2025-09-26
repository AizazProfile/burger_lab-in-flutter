import '../models/category.dart';
import '../models/burger.dart';
import '../models/ingredient.dart';

class SampleData {
  // 20 Burger Categories
  static List<BurgerCategory> getBurgerCategories() {
    return [
      BurgerCategory(
        id: '1',
        name: 'Classic Burgers',
        description: 'Traditional beef burgers with classic toppings',
        image: '🍔',
        itemCount: 5,
      ),
      BurgerCategory(
        id: '2',
        name: 'Chicken Delights',
        description: 'Juicy chicken burgers with special sauces',
        image: '🍗',
        itemCount: 6,
      ),
      BurgerCategory(
        id: '3',
        name: 'Veggie Paradise',
        description: 'Plant-based burgers for vegetarians',
        image: '🥬',
        itemCount: 4,
      ),
      BurgerCategory(
        id: '4',
        name: 'Spicy Heat',
        description: 'Hot and spicy burgers for thrill seekers',
        image: '🌶️',
        itemCount: 5,
      ),
      BurgerCategory(
        id: '5',
        name: 'Cheese Lovers',
        description: 'Extra cheesy burgers with multiple cheese types',
        image: '🧀',
        itemCount: 4,
      ),
      BurgerCategory(
        id: '6',
        name: 'BBQ Specials',
        description: 'Smoky BBQ flavored burgers',
        image: '🔥',
        itemCount: 3,
      ),
      BurgerCategory(
        id: '7',
        name: 'Breakfast Burgers',
        description: 'Morning burgers with eggs and bacon',
        image: '🥓',
        itemCount: 4,
      ),
      BurgerCategory(
        id: '8',
        name: 'Seafood Special',
        description: 'Fish and shrimp burgers from the ocean',
        image: '🐟',
        itemCount: 3,
      ),
      BurgerCategory(
        id: '9',
        name: 'Mini Sliders',
        description: 'Small sized burgers perfect for sharing',
        image: '🍘',
        itemCount: 6,
      ),
      BurgerCategory(
        id: '10',
        name: 'Gourmet Collection',
        description: 'Premium burgers with exotic ingredients',
        image: '⭐',
        itemCount: 4,
      ),
      BurgerCategory(
        id: '11',
        name: 'Double Stack',
        description: 'Double patty burgers for big appetites',
        image: '🍔🍔',
        itemCount: 3,
      ),
      BurgerCategory(
        id: '12',
        name: 'Low Carb',
        description: 'Keto-friendly burgers without buns',
        image: '🥗',
        itemCount: 4,
      ),
      BurgerCategory(
        id: '13',
        name: 'International Fusion',
        description: 'Burgers inspired by world cuisines',
        image: '🌍',
        itemCount: 5,
      ),
      BurgerCategory(
        id: '14',
        name: 'Sweet & Savory',
        description: 'Unique burgers with sweet elements',
        image: '🍯',
        itemCount: 3,
      ),
      BurgerCategory(
        id: '15',
        name: 'Protein Power',
        description: 'High-protein burgers for fitness enthusiasts',
        image: '💪',
        itemCount: 4,
      ),
      BurgerCategory(
        id: '16',
        name: 'Crispy Crunch',
        description: 'Burgers with extra crispy elements',
        image: '🥖',
        itemCount: 4,
      ),
      BurgerCategory(
        id: '17',
        name: 'Mushroom Magic',
        description: 'Burgers featuring various mushroom varieties',
        image: '🍄',
        itemCount: 3,
      ),
      BurgerCategory(
        id: '18',
        name: 'Avocado Fresh',
        description: 'Fresh burgers with avocado goodness',
        image: '🥑',
        itemCount: 4,
      ),
      BurgerCategory(
        id: '19',
        name: 'Truffle Luxury',
        description: 'Luxury burgers with truffle flavors',
        image: '💎',
        itemCount: 2,
      ),
      BurgerCategory(
        id: '20',
        name: 'Kids Special',
        description: 'Kid-friendly mini burgers with fun shapes',
        image: '👶',
        itemCount: 5,
      ),
    ];
  }

  // Sample Burgers for each category
  static List<Burger> getBurgers() {
    return [
      // Classic Burgers
      Burger(
        id: '1',
        name: 'Big Classic',
        description: 'Beef patty, lettuce, tomato, onion, pickles, ketchup, mustard',
        price: 12.99,
        image: 'assets/images/big_classic.jpg',
        category: 'Classic Burgers',
        ingredients: ['Beef Patty', 'Lettuce', 'Tomato', 'Onion', 'Pickles', 'Ketchup', 'Mustard'],
      ),
      Burger(
        id: '2',
        name: 'Quarter Pounder',
        description: 'Quarter pound beef patty with cheese and special sauce',
        price: 14.99,
        image: 'assets/images/quarter_pounder.jpg',
        category: 'Classic Burgers',
        ingredients: ['Quarter Pound Beef', 'American Cheese', 'Special Sauce', 'Lettuce'],
      ),

      // Chicken Delights
      Burger(
        id: '3',
        name: 'Crispy Chicken Supreme',
        description: 'Crispy chicken breast with mayo and fresh vegetables',
        price: 13.99,
        image: 'assets/images/crispy_chicken.jpg',
        category: 'Chicken Delights',
        ingredients: ['Crispy Chicken', 'Mayo', 'Lettuce', 'Tomato', 'Red Onion'],
      ),
      Burger(
        id: '4',
        name: 'Grilled Chicken Ranch',
        description: 'Grilled chicken with ranch dressing and bacon',
        price: 15.99,
        image: 'assets/images/grilled_chicken_ranch.jpg',
        category: 'Chicken Delights',
        ingredients: ['Grilled Chicken', 'Ranch Dressing', 'Bacon', 'Lettuce'],
      ),

      // Veggie Paradise
      Burger(
        id: '5',
        name: 'Black Bean Burger',
        description: 'House-made black bean patty with avocado',
        price: 11.99,
        image: 'assets/images/black_bean_burger.jpg',
        category: 'Veggie Paradise',
        ingredients: ['Black Bean Patty', 'Avocado', 'Sprouts', 'Tomato', 'Vegan Mayo'],
      ),

      // Spicy Heat
      Burger(
        id: '6',
        name: 'Fire Burger',
        description: 'Spicy beef patty with jalapeños and hot sauce',
        price: 16.99,
        image: 'assets/images/fire_burger.jpg',
        category: 'Spicy Heat',
        ingredients: ['Spicy Beef Patty', 'Jalapeños', 'Hot Sauce', 'Pepper Jack Cheese'],
      ),

      // Cheese Lovers
      Burger(
        id: '7',
        name: 'Triple Cheese Melt',
        description: 'Three types of melted cheese on beef patty',
        price: 17.99,
        image: 'assets/images/triple_cheese.jpg',
        category: 'Cheese Lovers',
        ingredients: ['Beef Patty', 'Cheddar', 'Swiss', 'Provolone', 'Cheese Sauce'],
      ),
    ];
  }

  // Sample Ingredients for Custom Burger Builder
  static List<Ingredient> getIngredients() {
    return [
      // Buns
      Ingredient(
        id: 'bun_sesame',
        name: 'Sesame Bun',
        type: IngredientType.bun,
        price: 2.00,
        image: '🍞',
        description: 'Classic sesame seed bun',
      ),
      Ingredient(
        id: 'bun_brioche',
        name: 'Brioche Bun',
        type: IngredientType.bun,
        price: 3.00,
        image: '🥖',
        description: 'Premium buttery brioche bun',
      ),
      Ingredient(
        id: 'bun_whole_wheat',
        name: 'Whole Wheat Bun',
        type: IngredientType.bun,
        price: 2.50,
        image: '🍞',
        description: 'Healthy whole wheat bun',
      ),

      // Patties
      Ingredient(
        id: 'patty_beef',
        name: 'Beef Patty',
        type: IngredientType.patty,
        price: 5.00,
        image: '🥩',
        description: 'Juicy beef patty',
      ),
      Ingredient(
        id: 'patty_chicken',
        name: 'Chicken Patty',
        type: IngredientType.patty,
        price: 4.50,
        image: '🍗',
        description: 'Grilled chicken patty',
      ),
      Ingredient(
        id: 'patty_veggie',
        name: 'Veggie Patty',
        type: IngredientType.patty,
        price: 4.00,
        image: '🥬',
        description: 'Plant-based patty',
      ),

      // Cheese
      Ingredient(
        id: 'cheese_cheddar',
        name: 'Cheddar Cheese',
        type: IngredientType.cheese,
        price: 1.50,
        image: '🧀',
        description: 'Sharp cheddar cheese',
      ),
      Ingredient(
        id: 'cheese_swiss',
        name: 'Swiss Cheese',
        type: IngredientType.cheese,
        price: 1.75,
        image: '🧀',
        description: 'Creamy Swiss cheese',
      ),

      // Vegetables
      Ingredient(
        id: 'veg_lettuce',
        name: 'Lettuce',
        type: IngredientType.vegetable,
        price: 0.50,
        image: '🥬',
        description: 'Fresh iceberg lettuce',
      ),
      Ingredient(
        id: 'veg_tomato',
        name: 'Tomato',
        type: IngredientType.vegetable,
        price: 0.75,
        image: '🍅',
        description: 'Ripe tomato slices',
      ),
      Ingredient(
        id: 'veg_onion',
        name: 'Red Onion',
        type: IngredientType.vegetable,
        price: 0.50,
        image: '🧅',
        description: 'Crisp red onion rings',
      ),
      Ingredient(
        id: 'veg_pickle',
        name: 'Pickles',
        type: IngredientType.vegetable,
        price: 0.25,
        image: '🥒',
        description: 'Tangy dill pickles',
      ),

      // Sauces
      Ingredient(
        id: 'sauce_ketchup',
        name: 'Ketchup',
        type: IngredientType.sauce,
        price: 0.25,
        image: '🍅',
        description: 'Classic tomato ketchup',
      ),
      Ingredient(
        id: 'sauce_mustard',
        name: 'Mustard',
        type: IngredientType.sauce,
        price: 0.25,
        image: '🟡',
        description: 'Tangy yellow mustard',
      ),
      Ingredient(
        id: 'sauce_mayo',
        name: 'Mayo',
        type: IngredientType.sauce,
        price: 0.50,
        image: '⚪',
        description: 'Creamy mayonnaise',
      ),

      // Extras
      Ingredient(
        id: 'extra_bacon',
        name: 'Bacon',
        type: IngredientType.extra,
        price: 2.50,
        image: '🥓',
        description: 'Crispy bacon strips',
      ),
      Ingredient(
        id: 'extra_avocado',
        name: 'Avocado',
        type: IngredientType.extra,
        price: 2.00,
        image: '🥑',
        description: 'Fresh avocado slices',
      ),
    ];
  }
}