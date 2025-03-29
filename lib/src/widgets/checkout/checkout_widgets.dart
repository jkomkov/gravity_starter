import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // For View All Items button

import '../../constants/app_constants.dart';
import '../../models/cart_item.dart'; // For ItemPreviewTile
import '../../routing/app_router.dart';
import '../../utils/currency_formatter.dart'; // For ItemPreviewTile price

// --- Reusable Card for Checkout Sections ---
class CheckoutSectionCard extends StatelessWidget {
  final String title;
  final VoidCallback? onEdit; // Optional Edit button callback
  final Widget child;
  final EdgeInsetsGeometry padding; // Allow custom padding for child

  const CheckoutSectionCard({
    super.key,
    required this.title,
    this.onEdit,
    required this.child,
    this.padding = const EdgeInsets.all(kAppPadding), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Padding(
          // Add horizontal padding only to header if needed, or keep consistent
          padding: const EdgeInsets.symmetric(horizontal: kAppPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (onEdit != null)
                TextButton(
                  onPressed: onEdit,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // Visual density can make tap area feel tighter
                    visualDensity: VisualDensity.compact,
                  ),
                  child: const Text('Edit'), // Text color from theme
                ),
            ],
          ),
        ),
        const SizedBox(height: kAppGap * 0.75), // Space between title and card
        // Content Card
        Container(
          width: double.infinity,
          padding: padding, // Use provided padding
          decoration: BoxDecoration(
            color: kSurfaceColor, // Use constant
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorderColor), // Use constant
          ),
          child: child,
        ),
      ],
    );
  }
}


// --- Tile for Delivery Options ---
class DeliveryOptionTile extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final bool isSelected;
  // final VoidCallback? onTap; // No interaction needed for UI shell

  const DeliveryOptionTile({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.isSelected,
    // this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use background color directly on container for simplicity
      color: isSelected ? kPrimaryColor.withOpacity(0.1) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: kAppPadding, vertical: kAppGap),
      child: Row(
        children: [
          // Radio Button visual indicator
          Container(
            width: 20, height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: isSelected ? kPrimaryColor : kMutedTextColor,
                  width: 2),
            ),
            child: isSelected
                ? Center( // Show inner dot if selected
                    child: Container(
                      width: 10, height: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: kPrimaryColor),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: kAppGap),
          // Delivery Info Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(description, style: const TextStyle(fontSize: 12, color: kMutedTextColor)),
              ],
            ),
          ),
          // Price Text
          Text(price, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}


// --- Tile for Item Preview in Order Review ---
class ItemPreviewTile extends StatelessWidget {
  final CartItem item;

  const ItemPreviewTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kAppGap * 0.5), // Add vertical padding
      child: Row(
        children: [
          // Item Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: item.product.imageUrl,
              width: 50, height: 50, fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                  width: 50, height: 50, color: kSurfaceColor,
                  child: const Icon(Icons.error_outline, size: 18, color: kMutedTextColor)),
              placeholder: (context, url) => Container(width: 50, height: 50, color: kSurfaceColor),
            ),
          ),
          const SizedBox(width: kAppGap),
          // Item Details (Brand, Name)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.brand, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                Text(
                  item.product.itemName ?? 'Product',
                  style: const TextStyle(fontSize: 12, color: kMutedTextColor),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: kAppGap),
          // Item Price (Unformatted for brevity)
          Text(formatCurrency(item.product.price),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}