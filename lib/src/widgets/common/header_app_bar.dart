import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_constants.dart';
import '../../routing/app_router.dart'; // For cart navigation
import 'gradient_text.dart'; // Import the gradient text widget

// Custom AppBar implementing PreferredSizeWidget
class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartItemCount; // Accept cart count (will be dummy data for now)
  final VoidCallback? onMenuPressed; // Optional callback for menu button

  const HeaderAppBar({
    super.key,
    this.cartItemCount = 0, // Default to 0 for UI shell
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Leading Menu Icon
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        tooltip: 'Menu',
        onPressed: onMenuPressed ?? () {
          // Placeholder action for UI shell
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Menu Pressed'), duration: Duration(seconds: 1)),
          );
          // In a real app, this might open a drawer: Scaffold.of(context).openDrawer();
        },
      ),
      // Centered Gradient Title
      title: const GradientText(
        'GRAVITY',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
        ),
      ),
      centerTitle: true, // Ensure title is centered
      // Action Icons (Cart)
      actions: [
        Padding(
          // Adjust padding to align visually if needed
          padding: const EdgeInsets.only(right: kAppPadding - 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Cart Icon Button
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                tooltip: 'Shopping Bag',
                onPressed: () => context.goNamed(AppRoute.cart.name), // Navigate to Cart
              ),
              // Cart Badge (Conditional)
              if (cartItemCount > 0)
                Positioned(
                  top: 8, // Fine-tune position
                  right: 4, // Fine-tune position
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: kSecondaryColor, // Use pink/accent color
                      shape: BoxShape.circle,
                      border: Border.all(color: kBackgroundColor, width: 1.5),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      // Display count, cap at 9+ if needed
                      cartItemCount > 9 ? '9+' : '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      backgroundColor: kBackgroundColor, // Explicitly set background
      elevation: 0, // No shadow
      // Bottom Border
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Divider(height: 1.0, thickness: 1.0, color: kBorderColor),
      ),
    );
  }

  // Required implementation for PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0); // Standard AppBar height + border
}