// lib/main_app.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'src/constants/app_constants.dart'; // Use our constants
import 'src/routing/app_router.dart'; // Import router configuration

// Main application widget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the router configuration instance from our router class
    final GoRouter router = AppRouter.router;

    return MaterialApp.router(
      // Router Configuration
      routerConfig: router,

      // App Configuration
      debugShowCheckedModeBanner: false,
      title: 'Gravity UI Shell',

      // --- App Theme (Material 3 Dark) ---
      theme: ThemeData(
        // Enable Material 3
        useMaterial3: true,
        brightness: Brightness.dark,

        // Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor, // Base color for M3 generation
          brightness: Brightness.dark,
          background: kBackgroundColor,
          surface: kSurfaceColor, // Background for cards, dialogs etc.
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          onBackground: Colors.white,
          onSurface: Colors.white,
          onError: Colors.white,
          error: kErrorColor, // Use constant
        ),

        // Component Themes
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor, // Consistent background
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white, size: 20),
          titleTextStyle: TextStyle(
            // M3 defaults are usually good, but ensure consistency if needed
            color: Colors.white,
            fontSize: 16, // Match previous style
            fontWeight: FontWeight.w500,
          ),
        ),
        cardTheme: CardTheme(
          color: kSurfaceColor,
          elevation: 0, // Flat design
          margin: EdgeInsets.zero, // Remove default margins if using custom padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: kBorderColor), // Consistent border
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: kBorderColor,
          thickness: 1,
          space: 1, // No extra space around divider
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
             // backgroundColor: kPrimaryColor, // M3 uses tonal based on seed
             foregroundColor: Colors.white, // Text color
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
         outlinedButtonTheme: OutlinedButtonThemeData(
           style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: kBorderColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
           )
         ),
         textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: kPrimaryColor, // Accent color for text buttons
            ),
         ),

        // Font (Can rely on system default)
        // fontFamily: 'System',

        // Other theme properties...
        visualDensity: VisualDensity.adaptivePlatformDensity,
        highlightColor: kPrimaryColor.withOpacity(0.1),
        splashColor: kSecondaryColor.withOpacity(0.1),
      ),
    );
  }
}