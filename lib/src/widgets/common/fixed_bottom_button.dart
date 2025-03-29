import 'package:flutter/material.dart';
import '../../constants/app_constants.dart'; // Ensure constants are imported

// Reusable button typically used fixed at the bottom of screens
class FixedBottomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon; // Optional icon
  final bool isLoading; // Optional loading state

  const FixedBottomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false, // Default to not loading
  });

  @override
  Widget build(BuildContext context) {
    // Use ElevatedButton for standard button behavior and styling
    return ElevatedButton(
      // Disable interactions if loading
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Need transparent for gradient Ink
        padding: EdgeInsets.zero, // Remove padding, Ink provides it
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(double.infinity, 50), // Full width, fixed height
        elevation: 4, // Add some elevation
        shadowColor: kPrimaryColor.withOpacity(0.3), // Use theme color for shadow
      ),
      // Use Ink for gradient background and splash effect control
      child: Ink(
        decoration: BoxDecoration(
          gradient: kPrimaryGradient, // Apply gradient from constants
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          // Ensure container respects minimum size from ElevatedButton style
          constraints: const BoxConstraints(minHeight: 50.0),
          alignment: Alignment.center,
          child: isLoading
              // Show spinner if loading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.5, color: Colors.white))
              // Show icon and label if not loading
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}