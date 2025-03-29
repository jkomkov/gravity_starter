import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_constants.dart';
import '../../routing/app_router.dart'; // Import for routing

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center, // Center content within available space
      padding: const EdgeInsets.all(kAppPadding * 2), // Generous padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
        children: [
          const Icon(Icons.shopping_bag_outlined, size: 80, color: kMutedTextColor),
          const SizedBox(height: kAppGap * 1.5),
          Text(
            'Your bag is empty',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600), // Use theme text style
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kAppGap),
          Text(
            "Looks like you haven't added anything yet. Start exploring!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kMutedTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kAppGap * 2.5),
          // Use ElevatedButton for better visibility
          ElevatedButton(
            onPressed: () => context.goNamed(AppRoute.home.name), // Navigate home
            style: ElevatedButton.styleFrom(
              // Use primary gradient for background
              padding: EdgeInsets.zero, // Remove padding for manual gradient container
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 3, // Add subtle elevation
            ),
            child: Ink( // Use Ink for gradient effect on button
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                alignment: Alignment.center,
                child: const Text('Explore Products', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}