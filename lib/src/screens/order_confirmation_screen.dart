import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // For navigation

import '../constants/app_constants.dart'; // Use constants
import '../routing/app_router.dart'; // Use route names

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // No AppBar for a clean confirmation look
      backgroundColor: kBackgroundColor, // Ensure background is black
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kAppPadding * 2), // Generous padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Success Icon with Gradient
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => kPrimaryGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded, // Use a filled or outlined icon
                  size: 80,
                  // Color is ignored due to ShaderMask, but provide one for semantics
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: kAppGap * 2),

              // Title Text
              Text(
                'Thank You!',
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kAppGap),

              // Confirmation Message
              Text(
                'Your order has been placed successfully.\nYou\'ll receive an email confirmation shortly.', // Example text
                style: textTheme.bodyLarge?.copyWith(color: kMutedTextColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kAppGap * 3), // More space before button

              // Back to Home Button (using ElevatedButton with gradient)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove padding for Ink gradient
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                ),
                onPressed: () {
                  // Navigate back to the home screen, clearing the stack
                  context.goNamed(AppRoute.home.name);
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: double.infinity, // Make button wide
                    padding: const EdgeInsets.symmetric(vertical: 14), // Adjust padding
                    alignment: Alignment.center,
                    child: const Text(
                      'Continue Shopping',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}