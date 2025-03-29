import 'package:flutter/material.dart';
import '../../constants/app_constants.dart'; // Use our gradient constant

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.gradient = kPrimaryGradient, // Use default primary gradient
  });

  @override
  Widget build(BuildContext context) {
    // Use a ShaderMask to paint the gradient over the text
    return ShaderMask(
      blendMode: BlendMode.srcIn, // Apply gradient color where text is drawn
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}