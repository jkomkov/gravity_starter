import 'package:flutter/foundation.dart'; // For @immutable

@immutable // Indicates the object's properties shouldn't change after creation
class Merchant {
  final String name;
  final String url; // Link to the merchant's website
  final String logoUrl; // URL for the SVG or image logo

  const Merchant({
    required this.name,
    required this.url,
    required this.logoUrl,
  });
}