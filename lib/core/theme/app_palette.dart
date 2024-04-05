import "dart:ui";

abstract class AppPalette {
  static const Color purple = Color.fromRGBO(187, 63, 221, 1);
  static const Color pink = Color.fromRGBO(227, 68, 134, 1);
  static const Color orange = Color.fromRGBO(198, 100, 64, 1);
  static const Color blue = Color.fromRGBO(67, 138, 223, 1);
  static const Color green = Color.fromRGBO(30, 193, 33, 1);
  static const Color yellow = Color.fromRGBO(218, 179, 39, 1);
  static const Color red = Color.fromRGBO(221, 58, 58, 1);
  static const Color teal = Color.fromRGBO(11, 185, 133, 1);
  static const Color brown = Color.fromRGBO(148, 99, 81, 1);

  static const Color background = Color.fromRGBO(24, 24, 32, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color grey = Color.fromRGBO(158, 158, 158, 1);
  static const Color error = Color.fromRGBO(255, 82, 82, 1);
  static const Color success = Color.fromRGBO(32, 239, 28, 1);
  static const Color borderColor = Color.fromRGBO(72, 72, 96, 1);
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0);

  static const List<Color> blogColors = [
    red,
    blue,
    green,
    yellow,
    orange,
    purple,
    pink,
    teal,
    brown,
  ];
}
