import 'package:flutter/foundation.dart';
import 'merchant.dart'; // Import the Merchant model

@immutable
class Product {
  final String id;
  final String brand;
  final double price; // Use double for price calculations later
  final String? itemName; // Optional, more specific name
  final String imageUrl;
  final Merchant? merchant; // Optional link to the merchant
  // Add other fields later if needed: description, sizes, colors etc.

  const Product({
    required this.id,
    required this.brand,
    required this.price,
    this.itemName,
    required this.imageUrl,
    this.merchant, // Make merchant optional
  });
}