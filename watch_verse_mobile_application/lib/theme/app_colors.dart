import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static final lightColors = _LightColors();
  static final darkColors = _DarkColors();

  static MyColors colors(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkColors
      : lightColors;
}

abstract class MyColors {
  MyColors();
  Color get primary;
  Color get secondary;
  Color get surface;
  Color get onSurface;
  Color get text;
  Color get button;
  Color get unselected;
}

class _LightColors implements MyColors {
  @override
  Color get primary => const Color(0xFFffffff);
  @override
  Color get secondary => const Color(0xFF000000);
  @override
  Color get surface => const Color(0xFFF5F5F5);

  @override
  Color get onSurface => const Color(0xFFF5F5F5);

  @override
  Color get text => Colors.black;
  @override
  Color get button => const Color.fromARGB(255, 1, 220, 180);

  @override
  Color get unselected => AppColors.lightColors.secondary.withAlpha(100);
}

class _DarkColors implements MyColors {
  @override
  Color get primary => const Color(0xFF000000);
  @override
  Color get secondary => const Color(0xFFffffff);
  @override
  Color get surface => const Color(0xFF080808);

  @override
  Color get onSurface => const Color(0xFF121212);

  @override
  Color get text => Colors.white;

  @override
  Color get button => const Color.fromARGB(255, 1, 220, 180);

  @override
  Color get unselected => AppColors.darkColors.secondary.withAlpha(100);
}

extension ColorExt on BuildContext {
  MyColors get colors => AppColors.colors(this);
}
