import 'package:intl/intl.dart'; // Make sure 'intl' is in pubspec.yaml

/// Formats a numeric amount into a currency string (e.g., $1,295.00).
///
/// Uses the intl package for proper formatting. Includes basic error handling.
String formatCurrency(double amount, {String symbol = '\$'}) {
  // Using NumberFormat for reliable currency formatting.
  // 'en_US' locale is used implicitly here for '$' symbol placement and separators.
  // For other locales, you might initialize NumberFormat differently.
  final format = NumberFormat.currency(
    symbol: symbol,
    decimalDigits: 2, // Ensure two decimal places
  );

  try {
    return format.format(amount);
  } catch (e) {
    // Fallback formatting in case of unexpected errors with intl
    print("Error formatting currency: $e");
    return '$symbol${amount.toStringAsFixed(2)}';
  }
}