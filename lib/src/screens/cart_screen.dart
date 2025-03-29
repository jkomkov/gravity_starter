import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import project files
import '../constants/app_constants.dart';
import '../data/mock_data.dart'; // Use mock cart items
import '../models/cart_item.dart';
import '../routing/app_router.dart';
import '../widgets/cart/cart_item_tile.dart';
import '../widgets/cart/empty_bag.dart';
import '../widgets/cart/order_summary_card.dart';
import '../widgets/common/fixed_bottom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MOCK cart items for the UI Shell
    final List<CartItem> cartItems = mockCartItems;
    final bool isEmpty = cartItems.isEmpty;

    // Calculate safe area padding for bottom button positioning
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bag'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20), // Use standard back icon
          tooltip: 'Back',
          onPressed: () {
             // Try to go back, otherwise go home (if deep linked)
            if (context.canPop()) {
               context.pop();
            } else {
               context.goNamed(AppRoute.home.name);
            }
          },
        ),
      ),
      // Use Stack to layer list content and fixed bottom area
      body: Stack(
        children: [
          // --- Main Content (List or Empty State) ---
          if (isEmpty)
            const Center(child: EmptyBagWidget())
          else
            ListView(
              padding: EdgeInsets.only(
                left: kAppPadding,
                right: kAppPadding,
                top: kAppPadding,
                // Leave enough space at the bottom for the fixed area + system padding
                bottom: 150 + bottomPadding,
              ),
              children: [
                // List of Cart Items
                ListView.separated(
                   physics: const NeverScrollableScrollPhysics(), // Disable nested scrolling
                   shrinkWrap: true, // Take only needed height
                   itemCount: cartItems.length,
                   itemBuilder: (context, index) => CartItemTile(item: cartItems[index]),
                   separatorBuilder: (context, index) => const Divider(height: kAppGap * 1.5), // Use Divider instead of padding
                ),
                const SizedBox(height: kAppGap * 2), // Space before summary
                // Order Summary Card
                const OrderSummaryCard(),
              ],
            ),

          // --- Fixed Bottom Checkout Area (only if cart is not empty) ---
          if (!isEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                    left: kAppPadding,
                    right: kAppPadding,
                    top: kAppPadding,
                    bottom: kAppPadding + bottomPadding), // Respect safe area
                // Add a subtle gradient or blur for better separation
                decoration: BoxDecoration(
                  color: kBackgroundColor.withOpacity(0.95), // Slightly transparent
                  border: const Border(top: BorderSide(color: kBorderColor)),
                  boxShadow: [ // Add shadow to lift it visually
                      BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)
                  ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Take minimum height
                  children: [
                    // Checkout Button
                    FixedBottomButton(
                      label: 'Proceed to Checkout',
                      onPressed: () => context.goNamed(AppRoute.checkout.name), // Navigate to Checkout
                      icon: Icons.lock_outline, // Use a relevant icon
                    ),
                    const SizedBox(height: 10),
                    // Continue Shopping Button
                    TextButton(
                      onPressed: () => context.pop(), // Go back from where cart was opened
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(color: kMutedTextColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}