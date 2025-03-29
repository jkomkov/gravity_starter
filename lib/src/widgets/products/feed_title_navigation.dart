import 'package:flutter/material.dart';
import '../../constants/app_constants.dart'; // Ensure constants are imported

class FeedTitleNavigation extends StatelessWidget {
  final String title;
  final int currentIndex;
  final int itemCount;
  final VoidCallback? onPrevious; // Callback when prev button tapped
  final VoidCallback? onNext;     // Callback when next button tapped

  const FeedTitleNavigation({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.itemCount,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if buttons should be enabled
    final bool canGoPrevious = onPrevious != null && currentIndex > 0;
    final bool canGoNext = onNext != null && currentIndex < itemCount - 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: kSurfaceColor, // Use constant
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorderColor), // Use constant
      ),
      child: Row(
        children: [
          // Previous Button
          _NavButton(
              icon: Icons.chevron_left,
              onPressed: canGoPrevious ? onPrevious : null // Disable if needed
          ),
          const SizedBox(width: kAppGap), // Use constant

          // Center Title Section
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Take minimum vertical space
              children: [
                const Text(
                  'CURRENTLY FINDING YOU:',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: kMutedTextColor, // Use constant
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 3),
                // Animate title changes if desired (using AnimatedSwitcher maybe)
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: kAccentTextColor, // Use constant
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Prevent long titles breaking layout
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(width: kAppGap), // Use constant

          // Next Button
          _NavButton(
              icon: Icons.chevron_right,
              onPressed: canGoNext ? onNext : null // Disable if needed
          ),
        ],
      ),
    );
  }
}

// Helper widget for the navigation buttons
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _NavButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    return Material( // Provides splash effect and corrects visual density
      color: kBorderColor.withOpacity(0.7), // Slightly transparent background
      shape: const CircleBorder(),
      elevation: 0, // No elevation needed
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container( // Container defines size and holds icon
          width: 24,
          height: 24,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 18,
            // Dim the icon color if disabled
            color: enabled ? kMutedTextColor : kMutedTextColor.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}