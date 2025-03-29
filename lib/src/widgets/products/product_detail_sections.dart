import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../models/product.dart'; // Import Product for ProductInfoSection
import '../../utils/currency_formatter.dart'; // For formatting price

// Section for basic Product Info (Brand, Name, Price)
class ProductInfoSection extends StatelessWidget {
  final Product product;
  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.brand,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Text(
          product.itemName ?? 'Unnamed Product',
          style: const TextStyle(fontSize: 16, color: kMutedTextColor, height: 1.4),
        ),
        const SizedBox(height: 10),
        // Use GradientText or just colored text for price
         Text(
           formatCurrency(product.price),
           style: const TextStyle(
             fontSize: 18,
             fontWeight: FontWeight.w600,
             // Using gradient requires GradientText widget
             // color: kPrimaryColor
           ),
         ),
        // Example using GradientText if preferred:
        // GradientText(
        //   formatCurrency(product.price),
        //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        // ),
      ],
    );
  }
}

// --- Placeholder Widgets for Other Sections ---

class RecommendedFitSection extends StatelessWidget {
  const RecommendedFitSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kAppPadding),
      decoration: BoxDecoration(
        color: kSurfaceColor.withOpacity(0.5), // Slightly transparent background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Recommended Fit', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
           const SizedBox(height: kAppGap),
           const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text('Size', style: TextStyle(color: kMutedTextColor, fontSize: 14)),
                 Text('Petite', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), // Example value
              ],
           ),
          const Divider(height: kAppGap * 1.5, thickness: 1, color: kBorderColor), // Use theme divider
          const Row( // Assistance Row
             children: [
                Icon(Icons.support_agent_outlined, size: 16, color: kAccentTextColor),
                SizedBox(width: 8),
                Expanded(child: Text('Not sure about size or fit? Just ask Olivia.', style: TextStyle(fontSize: 12, color: kAccentTextColor))),
             ],
          )
        ],
      ),
    );
  }
}

class TryOnButton extends StatelessWidget {
  const TryOnButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Using OutlinedButton for consistent styling
    return OutlinedButton.icon(
      icon: const Icon(Icons.accessibility_new, color: kSecondaryColor, size: 20), // Pink icon
      label: const Text('Try it on'), // Text color from theme
       style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48), // Full width, fixed height
          // Foreground/Side/Shape from theme
       ),
      onPressed: () {
        // Placeholder action
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('AR Try-On Feature Placeholder'), duration: Duration(seconds: 1)),
        );
      },
    );
  }
}

// Placeholder for Highlights/Notes
class HighlightsSection extends StatelessWidget {
  const HighlightsSection({super.key});

   Widget _buildHighlightItem(IconData icon, String text, {Color iconColor = kPrimaryColor}) {
     return Padding(
        padding: const EdgeInsets.only(bottom: kAppGap * 0.75),
        child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 10),
              Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: kMutedTextColor))),
           ],
        ),
     );
   }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const Row( // Section Title
             children: [
                Icon(Icons.notes_outlined, size: 18, color: kAccentTextColor),
                SizedBox(width: 6),
                Text('Olivia\'s Notes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
             ],
          ),
          const SizedBox(height: kAppGap),
          // Pros Section
          const Text('What you\'ll love', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kAccentTextColor)),
          const SizedBox(height: 8),
          _buildHighlightItem(Icons.check_circle_outline, 'Premium linen-blend fabric is perfect for warm climates'),
          _buildHighlightItem(Icons.check_circle_outline, 'The pleated details elevate it for evening dinners'),
          _buildHighlightItem(Icons.check_circle_outline, 'Neutral color pairs with all your existing accessories'),
          const Divider(height: kAppGap * 1.5), // Use theme divider
          // Cons/Notes Section
          const Text('Worth noting', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kAccentTextColor)),
          const SizedBox(height: 8),
          _buildHighlightItem(Icons.info_outline, 'May need light steaming after unpacking', iconColor: kMutedTextColor),
          _buildHighlightItem(Icons.info_outline, 'Dry clean only (not machine washable)', iconColor: kMutedTextColor),
      ],
    );
  }
}

// Placeholder for Reviews Section
class ReviewsSection extends StatelessWidget {
   final Function(String tag) onTagTap; // Callback when a tag is tapped
   const ReviewsSection({required this.onTagTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your personalized review score', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: kAppGap),
         Row( // Summary Row
           crossAxisAlignment: CrossAxisAlignment.baseline,
           textBaseline: TextBaseline.alphabetic,
           children: [
              const Text('4.8', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(width: 8),
              Row( // Stars
                 children: List.generate(5, (index) => Icon(
                    index < 4 ? Icons.star_rounded : Icons.star_half_rounded, // Example: 4.5 stars
                    color: Colors.amber[600], // Slightly darker amber
                    size: 18,
                 )),
              ),
              const SizedBox(width: 8),
              const Text('(28 reviews)', style: TextStyle(fontSize: 14, color: kMutedTextColor)),
           ],
         ),
         const SizedBox(height: kAppGap * 1.5),
         // Review Tags (using Wrap for layout)
         Wrap(
           spacing: 8.0, // Horizontal gap
           runSpacing: 8.0, // Vertical gap
           children: [
              // Using a helper widget for tags makes this cleaner
              _ReviewTagChip(label: 'Perfect for Miami', count: 12, onTap: () => onTagTap('Perfect for Miami')),
              _ReviewTagChip(label: 'True to size', count: 18, onTap: () => onTagTap('True to size')),
              _ReviewTagChip(label: 'Elegant', count: 15, onTap: () => onTagTap('Elegant')),
              _ReviewTagChip(label: 'Breathable', count: 9, onTap: () => onTagTap('Breathable')),
              _ReviewTagChip(label: 'Versatile', count: 14, onTap: () => onTagTap('Versatile')),
           ],
         )
      ],
    );
  }
}

// Helper widget for Review Tag Chips
class _ReviewTagChip extends StatelessWidget {
   final String label;
   final int count;
   final VoidCallback onTap;

  const _ReviewTagChip({required this.label, required this.count, required this.onTap});

   @override
   Widget build(BuildContext context) {
     // Use ActionChip for built-in tap handling and styling
     return ActionChip(
        onPressed: onTap,
        label: Text(label, style: const TextStyle(fontSize: 12, color: kAccentTextColor)),
        avatar: CircleAvatar( // Use CircleAvatar for the count bubble
          radius: 9,
          backgroundColor: kMutedTextColor.withOpacity(0.3),
          child: Text(
             '$count',
             style: const TextStyle(fontSize: 10, color: Colors.white),
           ),
        ),
        backgroundColor: kPrimaryColor.withOpacity(0.2),
        labelPadding: const EdgeInsets.only(left: 4, right: 8), // Adjust padding
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Overall chip padding
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none, // No border needed
     );
   }
}