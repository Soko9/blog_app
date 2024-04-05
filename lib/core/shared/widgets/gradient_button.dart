import "../../theme/app_palette.dart";
import "package:flutter/material.dart";

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPress;
  final double radius;
  final Color color;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPress,
    this.radius = 8.0,
    this.color = AppPalette.pink,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, AppPalette.purple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
              color: AppPalette.white,
            ),
          ),
        ),
      ),
    );
  }
}
