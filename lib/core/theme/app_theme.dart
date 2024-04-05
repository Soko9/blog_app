import "app_palette.dart";
import "package:flutter/material.dart";

abstract class AppTheme {
  static const String fontMontserrat = "Montserrat";
  static const String fontAntic = "Antic";
  static const String fontComfortaa = "Comfortaa";

  static _border([Color borderColor = AppPalette.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.5,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(24.0),
      );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.background,
    textTheme: Typography().white.apply(
          fontFamily: fontComfortaa,
        ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(24.0),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.pink),
      errorBorder: _border(AppPalette.error),
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
    ),
  );
}
