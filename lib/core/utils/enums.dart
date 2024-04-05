import "dart:ui";

import "package:blog_app/core/theme/app_palette.dart";

enum TAG {
  technology(color: AppPalette.red),
  entertainment(color: AppPalette.blue),
  programming(color: AppPalette.green),
  travel(color: AppPalette.yellow),
  business(color: AppPalette.orange),
  education(color: AppPalette.purple),
  health(color: AppPalette.teal),
  science(color: AppPalette.pink),
  sports(color: AppPalette.brown);

  final Color color;
  const TAG({required this.color});
}
