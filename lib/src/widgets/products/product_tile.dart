import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../models/product.dart';
import '../../utils/currency_formatter.dart';
import '../common/like_button.dart'; // Import TileLikeButton

class ProductTile extends StatelessWidget {
  final Product product;
  final int itemNumber;
  final VoidCallback onTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.itemNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define aspect ratio for the image part relative to the info footer height
    const double infoHeight = 36.0;
    // Estimate typical tile width based on 2-column grid and padding
    // This helps calculate a reasonable overall aspect ratio for the Card
    // For a screen width of ~400px, padding 15*2, gap 12 -> width ~ (400-30-12)/2 = 179
    // Let's aim for roughly 4:5 or 3:4 aspect ratio for the image itself
    const double imageAspectRatio = 0.75; // Width / Height

    return Card( // Card provides background, border, clipping
      // Removed explicit color/border as CardTheme handles it
      clipBehavior: Clip.antiAlias, // Ensure image corners are clipped
      child: InkWell( // Provides tap feedback and triggers onTap
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align footer content left
          children: [
            // --- Image Area with Overlays ---
            Expanded( // Takes remaining space in the Column
              child: Stack(
                fit: StackFit.expand, // Make stack fill the Expanded area
                children: [
                  // Product Image with Hero Animation
                  Positioned.fill(
                    child: Hero(
                      // Unique tag for hero animation (Grid -> Detail)
                      tag: 'product_image_${product.id}',
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        fit: BoxFit.cover, // Cover the area
                        // Placeholder while loading
                        placeholder: (context, url) => Container(color: kSurfaceColor),
                        // Widget to display on error
                        errorWidget: (context, url, error) => Container(
                          color: kSurfaceColor,
                          child: const Center(
                            child: Icon(Icons.broken_image_outlined, color: kMutedTextColor, size: 30),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Like Button Overlay
                  Positioned(
                    top: 8, // Adjust padding
                    left: 8,
                    // Use the specific TileLikeButton
                    child: TileLikeButton(
                        productId: product.id,
                        // In real app, get initial state from provider
                        initiallyLiked: product.id == 'r2' // Example: Like Khaite sweater initially
                    ),
                  ),

                  // Item Number Overlay
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        // Semi-transparent background with blur might need specific package (like frosted_glass)
                        // Using simple transparent black for now
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$itemNumber',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [ // Subtle shadow for readability
                              Shadow(blurRadius: 1.0, color: Colors.black54)
                          ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Info Footer ---
            Container(
              height: infoHeight,
              width: double.infinity, // Take full width
              padding: const EdgeInsets.symmetric(horizontal: kAppGap * 0.75), // Slightly less padding
              // Use card's background color (set by theme)
              // border: Border(top: BorderSide(color: kBorderColor)) // No need, Card handles it
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center, // Vertically center
                children: [
                  // Brand (takes available space, truncates)
                  Expanded(
                    child: Text(
                      product.brand,
                      style: const TextStyle(
                          fontSize: 12,
                          color: kMutedTextColor,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8), // Gap between brand and price
                  // Price (formatted)
                  Text(
                    formatCurrency(product.price),
                    style: const TextStyle(
                        fontSize: 12,
                        // Use accent gradient? Or single color for simplicity?
                        // Let's use primary color for now.
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}