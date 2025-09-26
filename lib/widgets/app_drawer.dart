import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/cart_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.shade400,
                      Colors.orange.shade600,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Text(
                        authProvider.currentUser?.name.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        .animate()
                        .scale(delay: 300.ms, duration: 600.ms),

                    const SizedBox(height: 12),

                    Text(
                      authProvider.currentUser?.name ?? 'User',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 600.ms)
                        .slideX(begin: -0.2, end: 0),

                    const SizedBox(height: 4),

                    Text(
                      authProvider.currentUser?.email ?? 'user@example.com',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 900.ms, duration: 600.ms)
                        .slideX(begin: -0.2, end: 0),
                  ],
                ),
              );
            },
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  delay: 1200,
                ),

                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return _buildDrawerItem(
                      context,
                      icon: Icons.shopping_cart,
                      title: 'Cart',
                      subtitle: cartProvider.itemCount > 0
                          ? '${cartProvider.itemCount} items'
                          : 'Empty',
                      trailing: cartProvider.itemCount > 0
                          ? Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${cartProvider.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          : null,
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/cart');
                      },
                      delay: 1400,
                    );
                  },
                ),

                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  title: 'Personal Info',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/profile');
                  },
                  delay: 1600,
                ),

                _buildDrawerItem(
                  context,
                  icon: Icons.restaurant_menu,
                  title: 'Custom Burger Builder',
                  subtitle: 'Build your dream burger',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/custom-burger');
                  },
                  delay: 1800,
                ),

                const Divider(),

                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return _buildDrawerItem(
                      context,
                      icon: themeProvider.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      title: themeProvider.isDarkMode
                          ? 'Light Mode'
                          : 'Dark Mode',
                      onTap: () {
                        themeProvider.toggleTheme();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                themeProvider.isDarkMode
                                    ? 'Switched to Dark Mode'
                                    : 'Switched to Light Mode'
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.orange,
                          ),
                        );
                      },
                      delay: 2000,
                    );
                  },
                ),

                _buildDrawerItem(
                  context,
                  icon: Icons.info,
                  title: 'About',
                  onTap: () {
                    _showAboutDialog(context);
                  },
                  delay: 2200,
                ),

                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  title: 'Logout',
                  iconColor: Colors.red,
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  delay: 2400,
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Divider(),
                Text(
                  'Burger Lab v1.0.0',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You feel like you are in the Burger world',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 2600.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        String? subtitle,
        Widget? trailing,
        Color? iconColor,
        required VoidCallback onTap,
        required int delay,
      }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Colors.orange,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      )
          : null,
      trailing: trailing,
      onTap: onTap,
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms)
        .slideX(begin: -0.2, end: 0);
  }

  void _showLogoutDialog(BuildContext context) {
    Navigator.of(context).pop(); // Close drawer first
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    Navigator.of(context).pop(); // Close drawer first
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.fastfood, color: Colors.orange),
              SizedBox(width: 8),
              Text('About Burger Lab'),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Version: 1.0.0\n'
                    'A delicious burger ordering app with custom burger builder.\n\n'
                    'Features:\n'
                    '• 20+ Burger Categories\n'
                    '• Custom Burger Builder\n'
                    '• Shopping Cart\n'
                    '• User Authentication\n'
                    '• Dark/Light Mode\n\n'
                    '"You feel like you are in the Burger world"',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}