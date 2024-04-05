import "../../theme/app_palette.dart";
import "package:flutter/material.dart";

class Loader extends StatelessWidget {
  final Color color;

  const Loader({super.key, this.color = AppPalette.pink});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: screenWidth * 0.2,
        height: screenWidth * 0.2,
        child: ClipOval(
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(8.0),
            color: color,
            backgroundColor: AppPalette.transparent,
          ),
        ),
      ),
    );
  }
}
