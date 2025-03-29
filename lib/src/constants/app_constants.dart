import 'package:flutter/material.dart';

// --- Colors ---
const Color kPrimaryColor = Color(0xFF8B5CF6); // Purple
const Color kSecondaryColor = Color(0xFFD946EF); // Pink / Magenta
const Color kBackgroundColor = Colors.black;
const Color kSurfaceColor = Color(0xFF171717); // Dark grey for cards/background elements
const Color kBorderColor = Color(0xFF404040); // Darker border/divider color
const Color kMutedTextColor = Color(0xFF9CA3AF); // Greyish text
const Color kAccentTextColor = Color(0xFFC4B5FD); // Light purple for accents
const Color kLikedColor = Color(0xFFEC4899); // Hot pink for liked state
const Color kErrorColor = Colors.redAccent;

// --- Gradients ---
const Gradient kPrimaryGradient = LinearGradient(
  colors: [kPrimaryColor, kSecondaryColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Gradient kPulseGradient = LinearGradient( // Teal/Green for Pulsating PTT
  colors: [Color(0xFF14B8A6), Color(0xFF10B981)],
  begin: Alignment.topLeft, end: Alignment.bottomRight,
);

const Gradient kPressedGradient = LinearGradient( // Pink/Red for Pressed PTT
  colors: [Color(0xFFEC4899), Color(0xFFEF4444)],
  begin: Alignment.topLeft, end: Alignment.bottomRight,
);


// --- Layout Spacing ---
const double kAppPadding = 15.0; // Standard padding around screens/elements
const double kAppGap = 12.0;     // Standard gap between elements

// --- Durations ---
const Duration kShortDuration = Duration(milliseconds: 200);
const Duration kMediumDuration = Duration(milliseconds: 300);
const Duration kLongDuration = Duration(milliseconds: 600);
const Duration kAnimationDuration = Duration(milliseconds: 300); // General animation

// --- Misc ---
// Basic placeholder for images that fail to load
const String kFallbackImageUrl = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="100%25" height="100%25" viewBox="0 0 300 400" preserveAspectRatio="none"%3E%3Crect width="100%25" height="100%25" fill="%23333"/%3E%3Ctext x="50%25" y="50%25" dominant-baseline="middle" text-anchor="middle" fill="%23999" font-size="14px" font-family="sans-serif"%3EImage unavailable%3C/text%3E%3C/svg%3E';