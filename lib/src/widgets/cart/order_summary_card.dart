import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../utils/currency_formatter.dart'; // Import formatter

// Define dummy values here for the UI Shell
const double _mockSubtotal = 2095.00;
const double _mockShipping = 0.00;
const double _mockTax = 125.70;
const double _mockTotal = _mockSubtotal + _mockShipping + _mockTax;


class OrderSummaryCard extends StatelessWidget {
  final bool isCheckout; // Flag to slightly change appearance if needed

  const OrderSummaryCard({this.isCheckout = false, super.key});

  @override
  Widget build(BuildContext context) {
    // Using mock values for the UI shell
    final subtotal = _mockSubtotal;
    final shipping = _mockShipping;
    final tax = _mockTax;
    final total = _mockTotal;

    return Container(
      padding: const EdgeInsets.all(kAppPadding),
      decoration: BoxDecoration(
        color: kSurfaceColor, // Use constant
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderColor), // Use constant
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600), // Use theme
          ),
          const SizedBox(height: kAppGap * 1.5),
          _SummaryRow(label: 'Subtotal', value: formatCurrency(subtotal)),
          _SummaryRow(label: 'Shipping', value: shipping == 0 ? 'Free' : formatCurrency(shipping)),
          _SummaryRow(label: 'Estimated Tax', value: formatCurrency(tax)),
          const Divider(height: kAppGap * 1.5, thickness: 1), // Use theme divider implicitly via context or define explicitly
          _SummaryRow(
            label: 'Total',
            value: formatCurrency(total),
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

// Helper Row Widget for Summary items
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.bodyMedium?.copyWith(
      color: isTotal ? Colors.white : kMutedTextColor,
      fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
    );
    final valueStyle = textTheme.bodyMedium?.copyWith(
       fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
       color: isTotal ? kPrimaryColor : Colors.white, // Highlight total value
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isTotal ? kAppGap * 0.5 : kAppGap * 0.4), // Adjust vertical spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}