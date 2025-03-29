import 'package:flutter/foundation.dart';
import 'product.dart'; // Import the Product model

@immutable
class ShoppingFrame {
  final String id;
  final String title;
  final List<Product> products; // A list of products in this frame

  const ShoppingFrame({
    required this.id,
    required this.title,
    required this.products,
  });
}