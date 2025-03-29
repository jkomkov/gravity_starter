import '../models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import project files
import '../constants/app_constants.dart';
import '../data/mock_data.dart'; // Use mock cart items for review/summary
import '../routing/app_router.dart';
import '../utils/currency_formatter.dart';
import '../widgets/cart/order_summary_card.dart'; // Reuse summary card
import '../widgets/checkout/checkout_widgets.dart'; // Import section widgets
import '../widgets/common/fixed_bottom_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using mock data for item count, preview and total in UI shell
    final cartItems = mockCartItems;
    final cartItemCount = cartItems.fold<int>(0, (int sum, CartItem item) => sum + item.quantity);
    final cartTotal = mockCartItems.fold<double>(0.0, (double sum, CartItem item) => sum + (item.product.price * item.quantity)) + 125.70; // Using mock items for total here

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          tooltip: 'Back to Bag',
          onPressed: () => context.pop(), // Go back to previous route (Cart)
        ),
      ),
      body: Stack(
        children: [
          // --- Scrolling Checkout Sections ---
          ListView(
            padding: EdgeInsets.only(
              // No horizontal padding here, section cards handle their own if needed
              top: kAppPadding,
              // Leave space for fixed button area + system padding
              bottom: 120 + bottomPadding,
            ),
            children: [
              // Wrap sections in horizontal padding if needed globally
              Padding(
                 padding: const EdgeInsets.symmetric(horizontal: kAppPadding),
                child: Column(
                   children: [
                     // --- Shipping Address ---
                     CheckoutSectionCard(
                       title: 'Shipping Address',
                       onEdit: () { /* Placeholder */ },
                       child: const Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Sofia Rodriguez', style: TextStyle(fontWeight: FontWeight.w600)),
                           SizedBox(height: 4),
                           Text('1234 Coral Way\nApartment 506\nMiami, FL 33145'),
                           SizedBox(height: 4),
                           Text('(305) 555-0123', style: TextStyle(color: kMutedTextColor)),
                         ],
                       )
                     ),
                     const SizedBox(height: kAppGap * 1.5),

                     // --- Payment Method ---
                     CheckoutSectionCard(
                       title: 'Payment Method',
                       onEdit: () { /* Placeholder */ },
                       child: const Row(
                         children: [
                           // Simple card icon placeholder
                           Icon(Icons.credit_card, size: 30, color: kMutedTextColor),
                           SizedBox(width: kAppGap),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('•••• •••• •••• 4578'),
                               Text('Expires 09/26', style: TextStyle(color: kMutedTextColor, fontSize: 12)),
                             ],
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(height: kAppGap * 1.5),

                     // --- Delivery Method ---
                     CheckoutSectionCard(
                       title: 'Delivery Method',
                       padding: EdgeInsets.zero, // Remove card padding for list tiles
                       child: const Column(
                         // Static delivery options for UI shell
                         children: [
                           DeliveryOptionTile(title: 'Standard Shipping', description: '3-5 business days', price: 'Free', isSelected: true),
                           Divider(height: 1), // Use Divider directly
                           DeliveryOptionTile(title: 'Express Shipping', description: '1-2 business days', price: '\$15.00', isSelected: false),
                           Divider(height: 1),
                           DeliveryOptionTile(title: 'Same Day Delivery', description: 'Available in Miami area', price: '\$25.00', isSelected: false),
                         ],
                       )
                     ),
                     const SizedBox(height: kAppGap * 1.5),

                     // --- Order Review ---
                     CheckoutSectionCard(
                       title: 'Order Review',
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('$cartItemCount item${cartItemCount == 1 ? '' : 's'} in your bag', style: const TextStyle(color: kMutedTextColor, fontSize: 14)),
                           const SizedBox(height: kAppGap * 0.5),
                           // Show first 1-2 items as preview
                           ...cartItems.take(2).map((CartItem item) => ItemPreviewTile(item: item)),
                           // "View All Items" Button
                           if (cartItems.length > 2) ...[
                             const SizedBox(height: kAppGap * 0.5),
                             Center(
                               child: TextButton(
                                 onPressed: () => context.goNamed(AppRoute.cart.name), // Go back to cart
                                 child: const Text('View all items'), // Text color from theme
                               ),
                             ),
                           ]
                         ],
                       )
                     ),
                     const SizedBox(height: kAppGap * 1.5),

                     // --- Final Order Summary ---
                     const OrderSummaryCard(isCheckout: true), // Reuse summary card
                   ],
                ),
              ),
            ],
          ),

          // --- Fixed Bottom Place Order Area ---
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
              decoration: BoxDecoration(
                color: kBackgroundColor.withOpacity(0.95),
                border: const Border(top: BorderSide(color: kBorderColor)),
                 boxShadow: [ BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10) ]
              ),
              child: Column(
                 mainAxisSize: MainAxisSize.min,
                children: [
                  // Order Total Row
                  Padding(
                    padding: const EdgeInsets.only(bottom: kAppGap),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const Text('Order Total:', style: TextStyle(fontSize: 14, color: Colors.white70)),
                         // Use GradientText for total? Or just colored?
                         Text(
                           formatCurrency(cartTotal), // Use mock total
                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
                         ),
                      ],
                    ),
                  ),
                  // Place Order Button
                  FixedBottomButton(
                    label: 'Place Order',
                    onPressed: () {
                       // Navigate to Confirmation Screen
                       context.pushNamed(AppRoute.confirmation.name); // Use push to keep checkout in stack
                    },
                    icon: Icons.lock_outline, // Or Icons.check
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