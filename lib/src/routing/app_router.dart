import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import screen widgets (we will create these files next)
import '../screens/product_grid_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/order_confirmation_screen.dart'; // New screen
import '../screens/not_found_screen.dart';

// Using an enum for route names is good practice for type safety
enum AppRoute {
  home,
  product,
  cart,
  checkout,
  confirmation,
}

// Configuration class for GoRouter
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/', // Start at the product grid
    debugLogDiagnostics: true, // Log navigation events in debug console
    errorBuilder: (context, state) => const NotFoundScreen(), // Fallback for invalid routes

    routes: [
      // Product Grid Screen (Home)
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const ProductGridScreen(),
        routes: [
          // Product Detail Screen (Nested under home for context, accessed via /product/:id)
          // We use a top-level route as well for simpler deep linking if needed later
        ],
      ),
      // Product Detail Screen (Top-level route for direct access)
      GoRoute(
        path: '/product/:id', // Use ':id' for path parameter
        name: AppRoute.product.name,
        builder: (context, state) {
          final productId = state.pathParameters['id'];
          // Basic error handling if ID is missing or invalid
          if (productId == null) {
             // Optionally navigate to NotFoundScreen or show error inline
            return const NotFoundScreen(message: 'Product ID is missing');
          }
          return ProductDetailScreen(productId: productId);
        },
      ),
      // Cart Screen
      GoRoute(
        path: '/cart',
        name: AppRoute.cart.name,
        builder: (context, state) => const CartScreen(),
      ),
      // Checkout Screen
      GoRoute(
        path: '/checkout',
        name: AppRoute.checkout.name,
        builder: (context, state) => const CheckoutScreen(),
      ),
       // Order Confirmation Screen
       GoRoute(
         path: '/confirmation',
         name: AppRoute.confirmation.name,
         builder: (context, state) => const OrderConfirmationScreen(),
       ),
    ],
  );
}