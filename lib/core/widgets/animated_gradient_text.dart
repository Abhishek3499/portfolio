import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AnimatedGradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const AnimatedGradientText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          AppColors.accentGradient.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(text, style: style),
    );
  }
}
