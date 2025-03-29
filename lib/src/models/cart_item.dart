import 'package:flutter/foundation.dart';
import 'product.dart'; // Import the Product model

@immutable
class CartItem {
  final String productId; // Keep product ID for reference
  final Product product; // Embed the full product details for easy display
  final int quantity;
  // Add selected size, color etc. later if needed

  const CartItem({
    required this.productId,
    required this.product,
    required this.quantity,
  });

  // Helper for potential updates later (not used in UI shell logic)
  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      productId: productId,
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}