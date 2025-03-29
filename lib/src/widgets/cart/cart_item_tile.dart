import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

import '../../constants/app_constants.dart';
import '../../models/cart_item.dart'; // Use CartItem model
import '../../utils/currency_formatter.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({required this.item, super.key});

  // Function to attempt launching URL (Keep for UI shell interaction)
  Future<void> _launchURL(BuildContext context, String urlString) async {
    final Uri? uri = Uri.tryParse(urlString);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Could not launch $urlString')),
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return Padding(
      // Add padding below each tile instead of divider for cleaner look
      padding: const EdgeInsets.only(bottom: kAppGap * 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image ---
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              width: 100,
              height: 100, // Keep aspect ratio roughly square or adjust
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 100, height: 100, color: kSurfaceColor),
              errorWidget: (context, url, error) => Container(
                width: 100, height: 100, color: kSurfaceColor,
                child: const Icon(Icons.broken_image_outlined, color: kMutedTextColor),
              ),
            ),
          ),
          const SizedBox(width: kAppGap),

          // --- Details Column ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand & Name
                Text(product.brand, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  product.itemName ?? 'Product',
                  maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 8),

                // Price & Size
                Text(formatCurrency(product.price), style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: kPrimaryColor)),
                const SizedBox(height: 4),
                const Text("Size: Petite", style: TextStyle(fontSize: 12, color: kMutedTextColor)), // Placeholder
                const SizedBox(height: 6),

                // Merchant Source Info
                Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     const Text("Sourced from ", style: TextStyle(fontSize: 12, color: kMutedTextColor)),
                     if (product.merchant?.url != null && product.merchant?.logoUrl != null)
                       InkWell(
                         onTap: () => _launchURL(context, product.merchant!.url),
                         child: Padding(
                           padding: const EdgeInsets.only(left: 4.0, top: 2, bottom: 2), // Add padding for easier tap
                           child: SvgPicture.network( // Use SvgPicture for SVG
                             product.merchant!.logoUrl,
                             height: 14, // Consistent height
                             colorFilter: const ColorFilter.mode(kMutedTextColor, BlendMode.srcIn), // Color SVG to match text
                             placeholderBuilder: (context) => const SizedBox(width: 30, height: 14), // Placeholder size
                           ),
                         ),
                       )
                     else if (product.merchant?.name != null)
                        Text(product.merchant!.name, style: const TextStyle(fontSize: 12, color: kMutedTextColor))
                     else
                        const Text("Our Partners", style: TextStyle(fontSize: 12, color: kMutedTextColor)),
                   ],
                 ),
                const SizedBox(height: kAppGap), // Space before actions

                // --- Actions Row ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity Display (Static for UI Shell)
                    Row(
                      children: [
                        // Non-functional buttons for visual representation
                        _QuantityButton(icon: Icons.remove, onPressed: item.quantity > 1 ? () {} : null), // Visually disable remove if qty is 1
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('${item.quantity}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        _QuantityButton(icon: Icons.add, onPressed: () {}), // Always enabled visually
                      ],
                    ),

                    // Remove Button (Non-functional)
                    TextButton.icon(
                      icon: const Icon(Icons.close, size: 16, color: kMutedTextColor), // Use close icon?
                      label: const Text('Remove', style: TextStyle(fontSize: 13, color: kMutedTextColor)),
                       style: TextButton.styleFrom(
                         padding: EdgeInsets.zero,
                         minimumSize: Size.zero,
                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: kSecondaryColor, // Splash color
                       ),
                      onPressed: () {
                        // No action in UI Shell
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Remove action placeholder'), duration: Duration(seconds: 1)),
                         );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper for Quantity Buttons (Visual Only in UI Shell)
class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed; // Still accept onPressed to control visual disabled state

  const _QuantityButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool isEnabled = onPressed != null;
    return Container( // Just a container, not tappable
      width: 26,
      height: 26,
      decoration: BoxDecoration(
          color: kSurfaceColor.withOpacity(0.8),
          shape: BoxShape.circle,
          border: Border.all(color: kBorderColor)),
      child: Icon(
        icon,
        size: 16,
        color: isEnabled ? Colors.white : kMutedTextColor, // Dim icon if disabled
      ),
    );
  }
}